package tests;

import autotest.console.app.exception.CustomExceptionErrorApp;
import org.testng.annotations.Test;

import static autotest.console.app.path.PathExpectScripts.*;
import static org.testng.Assert.assertThrows;

public class ConsoleAppNegativeTest extends BaseTests {

    @Test(description = "Получение домена по несуществующему ip")
    public void getDomainInvalidIp() {
        assertThrows("Ожидалась ошибка: \"Домен с ip адресом: $ip, не был найден\", но ее не было.",
                CustomExceptionErrorApp.class, () -> runExpectScript(GET_DOMAIN_AN_INVALID_IP));
    }

    @Test(description = "Добавление записи с существующим доменом")
    public void addAddressExistDomain() {
        assertThrows("Ожидалась ошибка: \"Домен first.domain уже есть, попробуйте заново.\", но ее не было.",
                CustomExceptionErrorApp.class, () -> runExpectScript(ADD_ADDRESS_EXIST_DOMAIN));
    }

    @Test(description = "Добавление записи с невалидным ip адресом")
    public void addAddressInvalidIp() {
        assertThrows("Ожидалась ошибка: \"Число 346 выходит за пределы диапазона от 0 до 255.\", но ее не было.",
                CustomExceptionErrorApp.class, () -> runExpectScript(ADD_ADDRESS_INVALID_IP));
    }
}
