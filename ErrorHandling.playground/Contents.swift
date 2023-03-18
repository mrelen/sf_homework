// перечисление и группировка возникновения ОшибокСети
enum NetworkError: Error {
    case error400
    case error404
    case error500
}

// не уверена, что нужно указывать переменные, но так было в модуле
var error400: Bool = true
var error404: Bool = false
var error500: Bool = false


// Обработка ошибкиСервера в генерирующей функции:
func handleServerError(errorCode: Int) {
    do {
        switch errorCode {
        case 400:
            throw NetworkError.error400
        case 404:
            throw NetworkError.error404
        case 500:
            throw NetworkError.error500
        default:
            print("Произошла неизвестная ошибка")
        }
    } catch NetworkError.error400 {
        print("Ошибка запроса (400)")
    } catch NetworkError.error404 {
        print("Ошибка. Ресурс не найден (404)")
    } catch NetworkError.error500 {
        print("Внутренняя ошибка сервера (500)")
    } catch {
        print("Произошла неизвестная ошибка")
    }
}


// Обработка переменной в генерирующей функции
func generateValue(check: Bool) throws -> Int {
    if check {
        throw NetworkError.error400
    } else {
        return 10
    }
}


// Обработка ошибок с использованием do-catch, Для каждой ошибки выведено сообщение в консоль
do {
    let result = try generateValue(check: true)
    print("Generated value: \(result)")
} catch NetworkError.error400 {
    print("Ошибка! Запрос неверный")
} catch {
    print("Произошла неизвестная ошибка")
}


// Функция для создания исключений для разных и одинаковых типов
enum ComparisonError: Error {
    case differentTypes
    case sameTypes
}

func checkTypesThrow<T, U>(first: T, second: U) throws {
    if type(of: first) == type(of: second) {
        throw ComparisonError.sameTypes
    } else {
        throw ComparisonError.differentTypes
    }
}

do {
    try checkTypesThrow(first: "hello", second: 123) // String Int
} catch ComparisonError.differentTypes {
    print("Ошибка! Разные типы")
} catch ComparisonError.sameTypes {
    print("Ошибка! одинаковые типы")
} catch {
    print("Произошла неизвестная ошибка!")
}


//функция, которая принимает на вход два значения и сравнивает их при помощи оператора равенства ==
func compareValues<T: Equatable>(first: T, second: T) -> Bool {
    return first == second
}

compareValues(first: "hello", second: "world") // false
compareValues(first: 123, second: 123) // true
