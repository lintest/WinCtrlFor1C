﻿Перем ЮнитТест, Ожидается;

#Область НаборТестов

Процедура ЗаполнитьНаборТестов(ЮнитТестирование) Экспорт
	
	ЮнитТест = ЮнитТестирование;
	Ожидается = ЮнитТестирование;
	
	ЮнитТест.ДобавитьТест("Тест_ИнициализацияБиблиотеки", "Инициализация библиотеки");
	ЮнитТест.ДобавитьТест("Тест_СвойстваУправлениеОкнами", "Свойства WindowsControl");
	ЮнитТест.ДобавитьТест("Тест_МетодыУправлениеОкнами", "Методы WindowsControl");
	ЮнитТест.ДобавитьТест("Тест_ПолучениеСнимкаЭкрана", "Получение снимка экрана");
	
КонецПроцедуры

Процедура Тест_ИнициализацияБиблиотеки() Экспорт
	
	ИдКомпоненты = "VanessaExt";
	МакетКомпоненты = ПолучитьМакет(ИдКомпоненты);
	АдресКомпоненты = ПоместитьВоВременноеХранилище(МакетКомпоненты);
	
	Ожидается.Тест("Подключение бибилиотеки компонент");
	Подключено = ПодключитьВнешнююКомпоненту(АдресКомпоненты, ИдКомпоненты, ТипВнешнейКомпоненты.Native);
	Ожидается.Что(Подключено).ЕстьИстина();
	
	ИменаКомпонент = Новый Структура("WindowsControl,ProcessControl,ClipboardControl,GitFor1C");
	Для каждого КлючЗначение из ИменаКомпонент Цикл
		Ожидается.Тест("Создание объкта: " + КлючЗначение.Ключ);
		ИмяКомпоненты = "AddIn." + ИдКомпоненты + "." + КлючЗначение.Ключ;
		Ожидается.Что(Новый(ИмяКомпоненты)).ИмеетТип(ИмяКомпоненты);
	КонецЦикла;
	
КонецПроцедуры

Процедура Тест_СвойстваУправлениеОкнами() Экспорт
	
	ВК = Новый("AddIn.VanessaExt.WindowsControl");
	
	Ожидается.Тест("Получить: Version").Что(ВК.Version).ИмеетТип("Строка");
	Ожидается.Тест("Получить: Версия").Что(ВК.Версия).ИмеетТип("Число");
	Ожидается.Тест("Получить: ВЕРСИЯ").Что(ВК.ВЕРСИЯ).ИмеетТип("Число");
	
	Ожидается.Тест("Получить: ProcessId").Что(ВК.ProcessId).Больше(0);

	
	ЮнитТест.ПроверитьУсловие(ВК.ProcessId, ВК.ProcessId > 0,"Получить: ProcessId", "ВК.ProcessId > 0");
	ЮнитТест.ПроверитьУсловие(ВК.ИдентификаторПроцесса, ВК.ИдентификаторПроцесса > 0, "Получить: ИдентификаторПроцесса", "ВК.ИдентификаторПроцесса > 0");
	
	ПримерТекста = "Текст примера";
	ВК.ТекстБуфераОбмена = ПримерТекста;
	ЮнитТест.ПроверитьЗначение(ПримерТекста, "Установить: ТекстБуфераОбмена");
	ЮнитТест.ПроверитьРавенство(ВК.ТекстБуфераОбмена, ПримерТекста, "Получить: ТекстБуфераОбмена");
	
	ДанныеКартинки = ПолучитьЛоготип1С();
	ПримерКартинки = Новый Картинка(ДанныеКартинки);
	ВК.КартинкаБуфераОбмена = ДанныеКартинки;
	ЮнитТест.ПроверитьЗначение(ДанныеКартинки, "Установить: КартинкаБуфераОбмена");
	
	ДанныеБуфера = ВК.КартинкаБуфераОбмена;
	КартинкаБуфера = Новый Картинка(ДанныеБуфера);
	ЮнитТест.ПроверитьТип(ДанныеБуфера, "ДвоичныеДанные", "Получить: КартинкаБуфераОбмена");
	ЮнитТест.ПроверитьРавенство(КартинкаБуфера.Формат(), ФорматКартинки.PNG, "Формат картинки буфера обмена");
	
	ЮнитТест.ПроверитьЗначение(ВК.СвойстваЭкрана, "Получить: СвойстваЭкрана");
	ЮнитТест.ПроверитьЗначение(ВК.СписокДисплеев, "Получить: СписокДисплеев");
	ЮнитТест.ПроверитьЗначение(ВК.СписокОкон, "Получить: СписокОкон");
	ЮнитТест.ПроверитьЗначение(ВК.АктивноеОкно, "Получить: АктивноеОкно");
	ЮнитТест.ПроверитьЗначение(ВК.ПозицияКурсора, "Получить: ПозицияКурсора");
	
КонецПроцедуры

Процедура Тест_МетодыУправлениеОкнами() Экспорт
	
	ВК = Новый("AddIn.VanessaExt.WindowsControl");
	
	КлиентТестирования = ВК.НайтиКлиентТестирования(48000);
	ЮнитТест.ПроверитьЗначение(КлиентТестирования, "НайтиКлиентТестирования()");
	
	ИдентификаторОкна = ВК.АктивноеОкно;
	СвойстваОкна = ВК.ПолучитьСвойстваОкна(0);
	ИдентификаторПроцесса = JSON(СвойстваОкна).ProcessId;
	ЮнитТест.ПроверитьЗначение(СвойстваОкна, "ПолучитьСвойстваОкна(0)");
	ЮнитТест.ПроверитьРавенство(ИдентификаторПроцесса, ВК.ProcessId, "СвойстваОкна.ProcessId = ВК.ProcessId");
	
	СписокПроцессов = ВК.ПолучитьСписокПроцессов(Истина);
	ЮнитТест.ПроверитьЗначение(СписокПроцессов, "ПолучитьСписокПроцессов(Истина)");
	
	СвойстваПроцесса = ВК.ПолучитьСвойстваПроцесса(ИдентификаторПроцесса);
	ЮнитТест.ПроверитьРавенство(JSON(СвойстваПроцесса).ProcessId, ИдентификаторПроцесса, "СвойстваПроцесса.ProcessId = ВК.ProcessId");
	
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСписокДисплеев(), "ПолучитьСписокДисплеев()");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСписокДисплеев(ИдентификаторОкна), "ПолучитьСписокДисплеев(hWnd)");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСвойстваДисплея(ИдентификаторОкна), "ПолучитьСвойстваДисплея(hWnd)");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСписокОкон(ИдентификаторПроцесса), "ПолучитьСписокОкон(PID)");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСвойстваОкна(ИдентификаторОкна), "ПолучитьСвойстваОкна(hWnd)");
	
	РазмерыОкна = ВК.ПолучитьРазмерОкна(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(РазмерыОкна, "ПолучитьРазмерОкна(hWnd)");
	Размеры = JSON(РазмерыОкна);
	
	ВК.АктивироватьОкно(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(Неопределено, "АктивироватьОкно(hWnd)");
	
	ВК.РаспахнутьОкно(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(Неопределено, "РаспахнутьОкно(hWnd)");
	
	ВК.РазвернутьОкно(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(Неопределено, "РазвернутьОкно(hWnd)");
	
	ВК.СвернутьОкно(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(Неопределено, "СвернутьОкно(hWnd)");
	
	ВК.Пауза(100);
	ЮнитТест.ПроверитьЗначение(Неопределено, "Пауза(100)");
	
	ВК.РазвернутьОкно(ИдентификаторОкна);
	ЮнитТест.ПроверитьЗначение(Неопределено, "РазвернутьОкно(hWnd)");
	
	ВК.УстановитьРазмерОкна(ИдентификаторОкна, Размеры.Width - 1, Размеры.Height - 1);
	ВК.УстановитьПозициюОкна(ИдентификаторОкна, Размеры.Left + 1, Размеры.Top + 1);
	РазмерыОкна = ВК.ПолучитьРазмерОкна(ИдентификаторОкна);
	НовыеРазмеры = JSON(РазмерыОкна);
	
	РазмерыСовпали = Истина
		И (Размеры.Left + 1 = НовыеРазмеры.Left) 
		И (Размеры.Top + 1 = НовыеРазмеры.Top) 
		И (Размеры.Top + 1 = НовыеРазмеры.Top) 
		И (Размеры.Width - 1 = НовыеРазмеры.Width) 
		И (Размеры.Height - 1 = НовыеРазмеры.Height)
		И (Размеры.Right = НовыеРазмеры.Right) 
		И (Размеры.Bottom = НовыеРазмеры.Bottom);
	
	ЮнитТест.ПроверитьУсловие(РазмерыОкна, РазмерыСовпали, "Размеры и позиция окна");
	
КонецПроцедуры

Процедура Тест_ПолучениеСнимкаЭкрана() Экспорт
	
	ВК = Новый("AddIn.VanessaExt.WindowsControl");
	
	ИдентификаторОкна = ВК.АктивноеОкно;
	РазмерыОкна = ВК.ПолучитьРазмерОкна(ИдентификаторОкна);
	Размеры = JSON(РазмерыОкна);
	
	СнимокОбласти = ВК.ПолучитьСнимокОбласти(Размеры.Left, Размеры.Top, Размеры.Width, Размеры.Height);
	Картинка = Новый Картинка(СнимокОбласти);
	ЮнитТест.ПроверитьУсловие(СнимокОбласти, Картинка.Формат() = ФорматКартинки.PNG, "ПолучитьСнимокОбласти()", ФорматКартинки.PNG);
	
	СнимокЭкрана = ВК.ПолучитьСнимокЭкрана();
	ЮнитТест.ПроверитьЗначение(СнимокЭкрана, "ПолучитьСнимокЭкрана()");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСнимокЭкрана(0), "ПолучитьСнимокЭкрана(0)");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСнимокЭкрана(1), "ПолучитьСнимокЭкрана(1)");
	ЮнитТест.ПроверитьЗначение(ВК.ПолучитьСнимокЭкрана(2), "ПолучитьСнимокЭкрана(2)");
	
	//Группа = ДобавитьГруппуТестов(Результаты, "Получение снимка экрана");
	//ТестВычислить(Группа, "ПолучитьСнимокОбласти()", "ВК.ПолучитьСнимокОбласти(" + L + "," + T + "," + W + "," + H + ")");
	//ТестВычислить(Группа, "ПолучитьСнимокЭкрана()", "ВК.ПолучитьСнимокЭкрана()");
	//ТестВычислить(Группа, "ПолучитьСнимокЭкрана(2)", "ВК.ПолучитьСнимокЭкрана(2)");
	//ТестВычислить(Группа, "ПолучитьСнимокЭкрана(1)", "ВК.ПолучитьСнимокЭкрана(1)");
	//ТестВычислить(Группа, "ПолучитьСнимокЭкрана(0)", "ВК.ПолучитьСнимокЭкрана(0)");
	//ТестВычислить(Группа, "НайтиФрагмент()", "ВК.НайтиФрагмент(Значение, ВК.ПолучитьСнимокОкна(hWnd))", "JSON(Значение).match > 0.7");
	//ТестВычислить(Группа, "НайтиНаЭкране()", "ВК.НайтиНаЭкране(ВК.ПолучитьСнимокОкна(hWnd))", "JSON(Значение).match > 0.7");
	//ТестВычислить(Группа, "ПолучитьСнимокОкна()", "ВК.ПолучитьСнимокОкна()");
	//ЗаписатьГруппуТестов(Группа);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедуры

&НаСервере
Функция JSON(ТекстJSON)
	
	Если ПустаяСтрока(ТекстJSON) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ПоляДаты = Новый Массив;
	ПоляДаты.Добавить("CreationDate");
	ПоляДаты.Добавить("date");
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ТекстJSON);
	Возврат ПрочитатьJSON(ЧтениеJSON, , ПоляДаты);
	
КонецФункции

&НаСервере
Функция ПолучитьЛоготип1С()
	
	ФайлРесурса = "v8res://mngbase/About.lf";
	ВременныйФайл = ПолучитьИмяВременногоФайла();
	КопироватьФайл(ФайлРесурса, ВременныйФайл);
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.Прочитать(ВременныйФайл);
	УдалитьФайлы(ВременныйФайл);
	
	Стр = ТекстовыйДокумент.ПолучитьТекст();
	НачПоз = СтрНайти(Стр, "{#base64:");
	КонПоз = СтрНайти(Стр, "}", , НачПоз);
	Стр = Сред(Стр, НачПоз + 9, КонПоз - НачПоз - 9);
	ДвоичныеДанные = Base64Значение(Стр);
	
	Картинка = Новый Картинка(ДвоичныеДанные);
	Соответствие = Новый Соответствие;
	Соответствие.Вставить("screenDensity", "xdpi");
	Возврат Картинка.ПолучитьДвоичныеДанные(Ложь, Соответствие);
	
КонецФункции

#КонецОбласти