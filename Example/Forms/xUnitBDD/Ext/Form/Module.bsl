﻿&НаКлиенте
Перем ОбъектВладелец Экспорт, ИдентификаторКомпоненты Экспорт;

&НаКлиенте
Перем ТекущийТест, ТекущийШаг, ПроверяемоеЗначение, ОжидаетсяОшибка, ТекущийТестПрерван;

&НаКлиенте
Перем ГСЛ;

#Область СлужебныеФункции

&НаКлиенте
Функция ПрочитатьДанныеJSON(ТекстJSON)
	
	ПоляДаты = Новый Массив;
	ПоляДаты.Добавить("CreationDate");
	ПоляДаты.Добавить("date");
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ТекстJSON);
	Возврат ПрочитатьJSON(ЧтениеJSON, , ПоляДаты);
	
КонецФункции

&НаКлиенте
Функция ЗаписатьПроблему(ТекстПроблемы)

	ОбъектВладелец.ЗаписатьПроблему(ТекущийТест, ТекущийШаг, ТекстПроблемы);
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция ПрерватьТест(Результат, Подробности)
	
	ТекущийТестПрерван = Истина;
	ОбъектВладелец.ПрерватьТест(ТекущийТест, ТекущийШаг, Результат, Подробности);
	
	Возврат ЭтотОбъект;
	
КонецФункции

#КонецОбласти

#Область ЭкспортныеМетоды

&НаКлиенте
Процедура Инициализация(Владелец, Идентификатор, Тест) Экспорт
	
	ОбъектВладелец = Владелец;
	ИдентификаторКомпоненты = Идентификатор;
	ТекущийТест = Тест;
	
КонецПроцедуры

&НаКлиенте
Функция Компонента(Знач ИмяКомпоненты = "") Экспорт
	
	Если ПустаяСтрока(ТекущийШаг.Наименование) Тогда
		ТекущийШаг.Наименование = "Создать: " + ИмяКомпоненты;
	КонецЕсли;
	ПроверяемоеЗначение = Новый("AddIn." + ИдентификаторКомпоненты + "." + ИмяКомпоненты);
	ТекущийШаг.Результат = ПроверяемоеЗначение;
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Тест(Знач Представление = "") Экспорт
	
	ТекущийТестПрерван = Ложь;
	ОжидаетсяОшибка = Ложь;
	ТекущийШаг = ОбъектВладелец.ДобавитьШаг(ТекущийТест, Представление);
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Что(Знач Значение = Неопределено) Экспорт
	
	ПроверяемоеЗначение = Значение;
	ТекущийШаг.Результат = Значение;
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Ошибка(Знач Значение = Неопределено) Экспорт
	
	Если Значение <> Неопределено Тогда
		ПроверяемоеЗначение = Значение;
		ТекущийШаг.Результат = Значение;
	КонецЕсли;
	
	ОжидаетсяОшибка = Истина;
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Вернуть() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ПроверяемоеЗначение;
	
КонецФункции	

&НаКлиенте
Функция JSON() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ПроверяемоеЗначение) Тогда
		ПроверяемоеЗначение = Неопределено;
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ТипЗнч(ПроверяемоеЗначение) <> Тип("Строка") Тогда
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Проверяемое значение не является строкой JSON");
	КонецЕсли;
	
	Попытка
		ПроверяемоеЗначение = ПрочитатьДанныеJSON(ПроверяемоеЗначение);
	Исключение
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Не удалось получить прочитать JSON");
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция Base64() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Попытка
		ПроверяемоеЗначение = Base64Значение(ПроверяемоеЗначение);
	Исключение
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Не удалось прочитать двоичные данные");
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Успешно() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ТекущийШаг.Эталон = "{success: true}";
	
	Если ТипЗнч(ПроверяемоеЗначение) <> Тип("Строка") Тогда
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Проверяемое значение не является строкой JSON");
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ПроверяемоеЗначение);
	ДанныеJSON = ПрочитатьJSON(ЧтениеJSON);
	
	ПроверкаНеПройдена = Истина;
	Если ТипЗнч(ДанныеJSON) = Тип("Структура") Тогда
		РезультатПроверки = Неопределено;
		Если ДанныеJSON.Свойство("success", РезультатПроверки) Тогда
			Если РезультатПроверки = Истина Тогда
				ПроверкаНеПройдена = Ложь;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Если ПроверкаНеПройдена Тогда
		Возврат ЗаписатьПроблему("Проверяемое значение не соответствует эталону");
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция Результат() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ТипЗнч(ПроверяемоеЗначение) <> Тип("Строка") Тогда
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Проверяемое значение не является строкой JSON");
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ПроверяемоеЗначение);
	ДанныеJSON = ПрочитатьJSON(ЧтениеJSON);
	
	Если Не ДанныеJSON.Свойство("result", ПроверяемоеЗначение) Тогда
		Возврат ПрерватьТест(ПроверяемоеЗначение, "Не удалось получить результат из данных JSON");
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция Получить(Знач Имя1 = Неопределено
	, Знач Имя2 = Неопределено
	, Знач Имя3 = Неопределено
	, Знач Имя4 = Неопределено
	, Знач Имя5 = Неопределено
	, Знач Имя6 = Неопределено
	, Знач Имя7 = Неопределено
) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ТекущийШаг.Наименование) Тогда
		ТекущийШаг.Наименование = "Получить: " + Имя1;
	КонецЕсли;
	
	Если ТипЗнч(ПроверяемоеЗначение) = Тип("Строка") Тогда
		Попытка
			ПроверяемоеЗначение = ПрочитатьДанныеJSON(ПроверяемоеЗначение);
		Исключение
			Возврат ПрерватьТест(ПроверяемоеЗначение, "Проверяемое значение не является строкой JSON");
		КонецПопытки;
	КонецЕсли;
	
	Попытка
		ПроверяемоеЗначение = ПроверяемоеЗначение[Имя1];
		ТекущийШаг.Результат = ПроверяемоеЗначение;
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекстОшибки = "Должна была возинкнуть ошибка при получении значения по индексу: " + Строка(Имя1);
			Возврат ПрерватьТест(ПроверяемоеЗначение, ТекстОшибки);
		КонецЕсли;
	Исключение
		Информация = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(Информация);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекущийШаг.Результат = ОписаниеОшибки;
		Иначе
			ТекстОшибки = "Не удалось получить значение по индексу: " + Строка(Имя1);
			Возврат ПрерватьТест(ОписаниеОшибки, ТекстОшибки);
		КонецЕсли;
	КонецПопытки;
	
	Если Имя2 = Неопределено Тогда
		Возврат ЭтотОбъект;
	Иначе
		Возврат Получить(Имя2, Имя3, Имя4, Имя5, Имя6, Имя7, Неопределено);
	КонецЕсли;
	
КонецФункции	

&НаКлиенте
Функция Установить(Знач Имя, Знач Значение) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ТекущийШаг.Наименование) Тогда
		ТекущийШаг.Наименование = "Установить: " + Имя;
	КонецЕсли;
	
	ТекущийШаг.Результат = Значение;

	Попытка
		ПроверяемоеЗначение[Имя] = Значение;
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекстОшибки = "Должна была возинкнуть ошибка при установке значения по индексу: " + Строка(Имя);
			Возврат ПрерватьТест(ПроверяемоеЗначение, ТекстОшибки);
		КонецЕсли;
	Исключение
		Информация = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(Информация);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекущийШаг.Результат = ОписаниеОшибки;
		Иначе
			ТекстОшибки = "Не удалось установить значение по индексу: " + Строка(Имя);
			Возврат ПрерватьТест(ОписаниеОшибки, ТекстОшибки);
		КонецЕсли;
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция ПолучитьФормулу(Знач Имя, Знач П1 = "ПУСТО", Знач П2 = "ПУСТО", Знач П3 = "ПУСТО", Знач П4 = "ПУСТО", Знач П5 = "ПУСТО", Знач П6 = "ПУСТО", Знач П7 = "ПУСТО")
	
	Формула = "";
	Количество = 7;
	Для Номер = 0 По Количество - 1 Цикл
		ИмяПараметра = "П" + (Количество - Номер);
		Если Не ПустаяСтрока(Формула) Тогда
			Формула = "," + Формула;
		КонецЕсли;
		Если Вычислить(ИмяПараметра) <> "ПУСТО" Тогда
			Формула = ИмяПараметра + Формула;
		КонецЕсли;
	КонецЦикла;
	
	Возврат "ПроверяемоеЗначение." + Имя + "(" + Формула + ")";
	
КонецФункции	

&НаКлиенте
Функция Функц(Знач Имя, Знач П1 = "ПУСТО", Знач П2 = "ПУСТО", Знач П3 = "ПУСТО", Знач П4 = "ПУСТО", Знач П5 = "ПУСТО", Знач П6 = "ПУСТО", Знач П7 = "ПУСТО") Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ТекущийШаг.Наименование) Тогда
		ТекущийШаг.Наименование = "Функция: " + Имя;
	КонецЕсли;
	
	Попытка
		Формула = ПолучитьФормулу(Имя, П1, П2, П3, П4, П5, П6, П7);
		ПроверяемоеЗначение = Вычислить(Формула);
		ТекущийШаг.Результат = ПроверяемоеЗначение;
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекстОшибки = "Должна была возинкнуть ошибка при вызове функции: " + Строка(Имя);
			Возврат ПрерватьТест(ПроверяемоеЗначение, ТекстОшибки);
		КонецЕсли;
	Исключение
		Информация = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(Информация);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекущийШаг.Результат = ОписаниеОшибки;
		Иначе
			ТекстОшибки = "Не удалось выполнить функцию: " + Строка(Имя);
			Возврат ПрерватьТест(ОписаниеОшибки, ТекстОшибки);
		КонецЕсли;
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Проц(Знач Имя, Знач П1 = "ПУСТО", Знач П2 = "ПУСТО", Знач П3 = "ПУСТО", Знач П4 = "ПУСТО", Знач П5 = "ПУСТО", Знач П6 = "ПУСТО", Знач П7 = "ПУСТО") Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ТекущийШаг.Наименование) Тогда
		ТекущийШаг.Наименование = "Процедура: " + Имя;
	КонецЕсли;
	
	Попытка
		Формула = ПолучитьФормулу(Имя, П1, П2, П3, П4, П5, П6, П7);
		Выполнить(Формула);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекстОшибки = "Должна была возинкнуть ошибка при вызове процедуры: " + Строка(Имя);
			Возврат ПрерватьТест(ПроверяемоеЗначение, ТекстОшибки);
		КонецЕсли;
	Исключение
		Информация = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(Информация);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекущийШаг.Результат = ОписаниеОшибки;
		Иначе
			ТекстОшибки = "Не удалось выполнить процедуру: " + Строка(Имя);
			Возврат ПрерватьТест(ОписаниеОшибки, ТекстОшибки);
		КонецЕсли;
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Сокр() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ПроверяемоеЗначение = СокрЛП(ПроверяемоеЗначение);
	ТекущийШаг.Результат = ПроверяемоеЗначение;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция Равно(Знач Значение) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ТекущийШаг.Эталон = Строка(Значение);
	Если ПроверяемоеЗначение <> Значение Тогда
		ЗаписатьПроблему("Проверяемое значение <" + Строка(ПроверяемоеЗначение) + "> не равно эталону <" + Строка(Значение) + ">");
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция ЕстьИстина() Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ТекущийШаг.Эталон = "Значение = Истина";
	Если ПроверяемоеЗначение <> Истина Тогда
		Возврат ЗаписатьПроблему("Проверяемое значение есть ""Ложь"", ожидается ""Истина""");
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция ИмеетТип(Знач ТипИлиИмяТипа) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ОжидаемыйТип = ?(ТипЗнч(ТипИлиИмяТипа) = Тип("Строка"), Тип(ТипИлиИмяТипа), ТипИлиИмяТипа);
	ТекущийШаг.Эталон = "ТипЗнч(Значение) = Тип(""" + Строка(ТипИлиИмяТипа) + """)";
	ТипПроверяемогоЗначения = ТипЗнч(ПроверяемоеЗначение);
	Если ТипПроверяемогоЗначения <> ОжидаемыйТип Тогда
		Возврат ЗаписатьПроблему("Неверный тип значения: " + ПроверяемоеЗначение);
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция Больше(Знач Значение) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ТекущийШаг.Эталон = "Значение > " + Строка(Значение);
	
	Если Не (ПроверяемоеЗначение > Значение) Тогда
		Возврат ЗаписатьПроблему("Проверяемое значение " + Строка(ПроверяемоеЗначение) + " должно быть больше " + Строка(Значение));
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция Меньше(Знач Значение) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	ТекущийШаг.Эталон = "Значение < " + Строка(Значение);
	
	Если Не (ПроверяемоеЗначение < Значение) Тогда
		Возврат ЗаписатьПроблему("Проверяемое значение " + Строка(ПроверяемоеЗначение) + " должно быть меньше " + Строка(Значение));
	КонецЕсли;
	
	Возврат ЭтотОбъект;
	
КонецФункции

&НаКлиенте
Функция ЭтоКартинка(Знач Формат = Неопределено) Экспорт
	
	Если ТекущийТестПрерван Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если Формат = Неопределено Тогда
		Формат = Вычислить("ФорматКартинки.PNG");
	КонецЕсли;
	
	Попытка
		ПроверяемаяКартинка = Новый Картинка(ПроверяемоеЗначение);
		Если ПроверяемаяКартинка.Формат() <> Формат Тогда
			ЗаписатьПроблему("Формат картинки не соответствует ожидаемому: " + Формат);
		КонецЕсли;
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекстОшибки = "Должна была возинкнуть ошибка при проверке картинки";
			Возврат ПрерватьТест(ПроверяемоеЗначение, ТекстОшибки);
		КонецЕсли;
	Исключение
		Информация = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(Информация);
		Если ОжидаетсяОшибка Тогда
			ОжидаетсяОшибка = Ложь;
			ТекущийШаг.Результат = ОписаниеОшибки;
		Иначе
			ТекстОшибки = "Не получить значение как картинку";
			Возврат ПрерватьТест(ОписаниеОшибки, ТекстОшибки);
		КонецЕсли;
	КонецПопытки;
	
	Возврат ЭтотОбъект;
	
КонецФункции	

&НаКлиенте
Функция СлучайныйТекст() Экспорт

	Если ГСЛ = Неопределено Тогда
		ГСЧ = Новый ГенераторСлучайныхЧисел();
	КонецЕсли;

	Возврат Строка(ГСЧ.СлучайноеЧисло(0, 999));	

КонецФункции	

#КонецОбласти
