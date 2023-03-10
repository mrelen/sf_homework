// Создай кортеж для двух человек с одинаковыми типами данных и параметрами.
let person1 = (name: "Иван", age: 30, city: "Москва")
let person2 = (name: "Юля", age: 25, city: "Питер")

//Одни значения доставай по индексу, а другие — по параметру.
print(person1.name) // prints "Иван"
print(person2.1) // prints 25
print(person1.city) // prints "Москва"
print(person2.age) // prints 25


/* Создай массив «дни в месяцах» (12 элементов содержащих количество дней в соответствующем месяце). Используя цикл for и этот массив:
 */
let daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
let monthNames = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]

// Выведи количество дней в каждом месяце
for i in 0..<daysInMonths.count {
    print("\(monthNames[i]): \(daysInMonths[i]) дней")
}




// Выведите количество дней в каждом месяце в обратном порядке
for i in (0..<daysInMonths.count).reversed() {
    print("\(monthNames[i]): \(daysInMonths[i]) дней")
}

// Подсчитай количество дней до конца года для произвольно выбранной даты
let chosenMonth = "April"
let chosenDay = 15
var remainingDays = 0
if let chosenMonthIndex = monthNames.firstIndex(of: chosenMonth) {
    let daysInChosenMonth = daysInMonths[chosenMonthIndex]
    remainingDays = daysInChosenMonth - chosenDay
    for i in (chosenMonthIndex+1)..<daysInMonths.count {
        remainingDays += daysInMonths[i]
    }
}
print("Количество дней до конца года: \(remainingDays)")




// Создай словарь, как список студентов, где имя и фамилия студента это ключ, а оценка за экзамен — значение.
var studentGrades = ["Иван Иванов": 4, "Юля Петрова": 5, "Василий Коваль": 3, "Елизавета Никонова": 5]

// Добавь в словарь новых одногруппников
studentGrades["Сергей Низов"] = 4
studentGrades["Светлана Огрова"] = 4

// Распечатать словарь учеников и оценок
print(studentGrades)





/* Повысь студенту оценку за экзамен. Если оценка положительная (4 или 5) или удовлетворительная (3), то выведи сообщение с поздравлением, отрицательная (1, 2) - отправь на пересдачу
 */
if let IvanGrade = studentGrades["Иван Иванов"] {
    studentGrades["Иван Иванов"] = IvanGrade + 1
    if IvanGrade >= 3 {
        print("Поздравляем, Иван Иванов! Ваша новая оценка: \(studentGrades["Иван Иванов"]!).")
    } else {
        print("Прости, Иван Иванов, у тебя слишком низкая оценка. Пожалуйста, пересдайте экзамен.")
    }
}



// Удали одного студента — он отчислен.
studentGrades["Василий Коваль"] = nil


// Подсчитай средний балл всей группы.
var totalScore = 0
for grade in studentGrades.values {
    totalScore += grade
}
let averageScore = totalScore / studentGrades.count

// Распечатать обновленный словарь и средний балл.
print(studentGrades)
print("Средний балл всей группы \(averageScore).")
