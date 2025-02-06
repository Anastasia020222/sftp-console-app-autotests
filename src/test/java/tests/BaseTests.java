package tests;

import autotest.console.app.exception.CustomExceptionErrorApp;
import practice.autotest.exception.CustomException;

import java.io.*;

public abstract class BaseTests {

    public void runExpectScript(String path) throws CustomException {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder("expect", path);
            Process process = processBuilder.start();

            StringBuilder out = stdoutThread(process);
            StringBuilder er = stderrThread(process);
            System.out.println(out);

            int exitCode = process.waitFor();
            if (exitCode != 0) {
                throw new CustomExceptionErrorApp("Процесс завершился с кодом: " + exitCode + ". Ошибка: " + er);
            }
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException("Ошибка при выполнении Expect-скрипта: " + e.getMessage(), e);
        }
    }

    private void readStream(InputStream stream, StringBuilder output) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(stream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private StringBuilder stdoutThread(Process process) {
        StringBuilder output = new StringBuilder();
        try {
            Thread outputThread = new Thread(() -> readStream(process.getInputStream(), output));
            outputThread.start();
            outputThread.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return output;
    }

    private StringBuilder stderrThread(Process process) {
        StringBuilder errorOutput = new StringBuilder();
        try {
            Thread stderrThread = new Thread(() -> readStream(process.getErrorStream(), errorOutput));
            stderrThread.start();
            stderrThread.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return errorOutput;
    }
}
