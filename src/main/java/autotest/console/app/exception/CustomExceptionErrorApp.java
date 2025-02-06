package autotest.console.app.exception;

public class CustomExceptionErrorApp extends RuntimeException {

    public CustomExceptionErrorApp(String message) {
        super(message);
    }

    public CustomExceptionErrorApp(String message, Throwable cause) {
        super(message, cause);
    }

    public CustomExceptionErrorApp(Throwable cause) {
        super(cause);
    }
}
