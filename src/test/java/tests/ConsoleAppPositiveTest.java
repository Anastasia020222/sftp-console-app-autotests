package tests;

import autotest.console.app.exception.CustomExceptionErrorApp;
import org.testng.annotations.Test;

import static autotest.console.app.path.PathExpectScripts.*;
import static org.testng.Assert.*;

public class ConsoleAppPositiveTest extends BaseTests {

    @Test(description = "Проверяем получение домена")
    public void checkGetAddressDomain() {
        try {
            runExpectScript(GET_DOMAIN);
        } catch (CustomExceptionErrorApp e) {
            fail(e.getMessage());
        }
    }

    @Test(description = "Проверяем добавление новой записи")
    public void checkAddAddressDomain() {
        try {
            runExpectScript(ADD_NEW_ADDRESS_DOMAIN);
        } catch (CustomExceptionErrorApp e) {
            fail(e.getMessage());
        }
    }

    @Test(description = "Проверяем удаление записи")
    public void checkDeleteAddressDomain() {
        try {
            runExpectScript(DELETE_ADDRESS_DOMAIN);
        } catch (CustomExceptionErrorApp e) {
            fail(e.getMessage());
        }
    }
}
