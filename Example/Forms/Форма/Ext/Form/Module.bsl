﻿&НаКлиенте
Перем ВнешняяКомпонента;

&НаКлиенте
Перем БуферОбмена;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МакетКомпоненты = РеквизитФормыВЗначение("Объект").ПолучитьМакет("SetWindow");
	МестоположениеКомпоненты = ПоместитьВоВременноеХранилище(МакетКомпоненты, УникальныйИдентификатор);
	
	МакетЛоготип1С = РеквизитФормыВЗначение("Объект").ПолучитьМакет("Logo1C");
	КартинкаЛоготип1С = ПоместитьВоВременноеХранилище(МакетЛоготип1С, УникальныйИдентификатор);
	
	РазмерПоГоризонтали = 1280;
	РазмерПоВертикали = 960;
	ПортПодключения = 48000;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	НачатьПодключениеВнешнейКомпоненты(
		Новый ОписаниеОповещения("ПодключениеВнешнейКомпонентыЗавершение", ЭтаФорма, Истина),
		МестоположениеКомпоненты, "SetWindow", ТипВнешнейКомпоненты.Native
	); 
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКомпоненту(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("УстановкаВнешнейКомпонентыЗавершение", ЭтаФорма, Истина);
	НачатьУстановкуВнешнейКомпоненты(ОписаниеОповещения, МестоположениеКомпоненты);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановкаВнешнейКомпонентыЗавершение(ДополнительныеПараметры) Экспорт
	
	НачатьПодключениеВнешнейКомпоненты(
		Новый ОписаниеОповещения("ПодключениеВнешнейКомпонентыЗавершение", ЭтаФорма, ДополнительныеПараметры),
		МестоположениеКомпоненты, "SetWindow", ТипВнешнейКомпоненты.Native
	); 
	
КонецПроцедуры	

&НаКлиенте
Процедура ПодключитьКомпоненту(Команда)

	НачатьПодключениеВнешнейКомпоненты(
		Новый ОписаниеОповещения("ПодключениеВнешнейКомпонентыЗавершение", ЭтаФорма, Истина),
		МестоположениеКомпоненты, "SetWindow", ТипВнешнейКомпоненты.Native
	); 
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключениеВнешнейКомпонентыЗавершение(Подключение, ДополнительныеПараметры) Экспорт
	
	Если Подключение Тогда
		ВнешняяКомпонента = Новый("AddIn.SetWindow.WindowsControl");
		БуферОбмена = Новый("AddIn.SetWindow.ClipboardControl");
		ОписаниеОповещения = Новый ОписаниеОповещения("ПолученаВерсияКомпоненты", ЭтотОбъект);
		ВнешняяКомпонента.НачатьПолучениеВерсия(ОписаниеОповещения);
	ИначеЕсли ДополнительныеПараметры = Истина Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("УстановкаВнешнейКомпонентыЗавершение", ЭтаФорма, Ложь);
		НачатьУстановкуВнешнейКомпоненты(ОписаниеОповещения, МестоположениеКомпоненты);
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолученаВерсияКомпоненты(Значение, ДополнительныеПараметры) Экспорт
	
	Версия = Значение;
	
КонецПроцедуры	

&НаКлиенте
Функция ПрочитатьСтрокуJSON(ТекстJSON)
	
	Если ПустаяСтрока(ТекстJSON) Тогда
		Возврат Неопределено;
	КонецЕсли;

	ПоляДаты = Новый Массив;
	ПоляДаты.Добавить("CreationDate");
		
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ТекстJSON);
	Возврат ПрочитатьJSON(ЧтениеJSON, , ПоляДаты);
	
КонецФункции

&НаКлиенте
Процедура ПолучитьСписокПроцессов(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСписокПроцессов", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСписокПроцессов(ОписаниеОповещения, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьПроцессы1С(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСписокПроцессов", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСписокПроцессов(ОписаниеОповещения, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученСписокПроцессов(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(РезультатВызова);
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		СписокПроцессов.Очистить();
		Для каждого Стр из Данные Цикл
			НоваяСтр = СписокПроцессов.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтр, Стр);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьДанныеПроцесса(Команда)
	
	ТекущиеДанные = Элементы.СписокПроцессов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда Возврат КонецЕсли;
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученыСвойстваОбъекта", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСвойстваПроцесса(ОписаниеОповещения, ТекущиеДанные.ProcessId);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученыСвойстваОбъекта(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(РезультатВызова);
	Если ТипЗнч(Данные) = Тип("Структура") Тогда
		СвойстваОбъекта.Очистить();
		Для каждого КлючЗначение из Данные Цикл
			НоваяСтр = СвойстваОбъекта.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтр, КлючЗначение);
		КонецЦикла;
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаСвойстваОбъекта;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьСписокОкон(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСписокОкон", ЭтотОбъект);
	ВнешняяКомпонента.НачатьПолучениеСписокОкон(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученСписокОкон(Значение, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(Значение);
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		СписокОкон.Очистить();
		Для каждого Стр из Данные Цикл
			ЗаполнитьЗначенияСвойств(СписокОкон.Добавить(), Стр);
		КонецЦикла;
		ОписаниеОповещения = Новый ОписаниеОповещения("ПолученоАктивноеОкно", ЭтотОбъект);
		ВнешняяКомпонента.НачатьПолучениеАктивноеОкно(ОписаниеОповещения);
	КонецЕсли;
	
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаСписокОкон;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолученоАктивноеОкно(Значение, ДополнительныеПараметры) Экспорт
	
	Для каждого Стр из СписокОкон.НайтиСтроки(Новый Структура("window", Значение)) Цикл
		Элементы.СписокОкон.ТекущаяСтрока = Стр.ПолучитьИдентификатор();
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОконПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.СписокОкон.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		ИдентификаторПроцесса = "";
		ДескрипторОкна = 0;
		ЗаголовокОкна = "";
	Иначе
		ИдентификаторПроцесса = ТекущиеДанные.ProcessId;
		ДескрипторОкна = ТекущиеДанные.window;
		ЗаголовокОкна = ТекущиеДанные.title;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРазмер(ПозицияПоГоризонтали, ПозицияПоВертикали, РазмерПоГоризонтали, РазмерПоВертикали)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученыСвойстваДисплея", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСвойстваДисплея(ОписаниеОповещения, ДескрипторОкна);
	ВнешняяКомпонента.НачатьВызовУстановитьРазмерОкна(Новый ОписаниеОповещения, ДескрипторОкна, РазмерПоГоризонтали, РазмерПоВертикали);
	ВнешняяКомпонента.НачатьВызовРазрешитьИзменятьРазмер(Новый ОписаниеОповещения, ДескрипторОкна, НЕ ЗапретитьИзменятьРазмер);
	ВнешняяКомпонента.НачатьВызовАктивироватьОкно(Новый ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученыСвойстваДисплея(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(РезультатВызова);
	Если ТипЗнч(Данные) = Тип("Структура") Тогда
		ВнешняяКомпонента.НачатьВызовУстановитьПозициюОкна(
			Новый ОписаниеОповещения, ДескрипторОкна, Данные.Left, Данные.Top
		);
	КонецЕсли;
	
КонецПроцедуры	


#Область ТипичныеРазмерыОкон

&НаКлиенте
Процедура ПроизвольныйРазмер(Команда)

	УстановитьРазмер(ПозицияПоГоризонтали, ПозицияПоВертикали, РазмерПоГоризонтали, РазмерПоВертикали);
	
КонецПроцедуры

&НаКлиенте
Процедура Размер800х600(Команда)
	УстановитьРазмер(0, 0, 800, 600);
КонецПроцедуры

&НаКлиенте
Процедура Размер960х720(Команда)
	УстановитьРазмер(0, 0, 960, 720);
КонецПроцедуры

&НаКлиенте
Процедура Размер1024х768(Команда)
	УстановитьРазмер(0, 0, 1024, 768);
КонецПроцедуры

&НаКлиенте
Процедура Размер1280х960(Команда)
	УстановитьРазмер(0, 0, 1280, 960);
КонецПроцедуры

&НаКлиенте
Процедура Широкий960х540(Команда)
	УстановитьРазмер(0, 0, 960, 540);
КонецПроцедуры

&НаКлиенте
Процедура Широкий1024х576(Команда)
	УстановитьРазмер(0, 0, 1024, 576);
КонецПроцедуры

&НаКлиенте
Процедура Широкий1280х720(Команда)
	УстановитьРазмер(0, 0, 1280, 720);
КонецПроцедуры

&НаКлиенте
Процедура Широкий1600х900(Команда)
	УстановитьРазмер(0, 0, 1600, 900);
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура СделатьСнимок(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСнимок", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСнимокОкна(ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура СнимокЭкрана(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСнимок", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСнимокЭкрана(ОписаниеОповещения, 0);
	
КонецПроцедуры

&НаКлиенте
Процедура СнимокОкна(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСнимок", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСнимокЭкрана(ОписаниеОповещения, 1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученСнимок(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	ДанныеКартинки = ПоместитьВоВременноеХранилище(РезультатВызова, УникальныйИдентификатор);
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаКартинка;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаголовокОкна(Команда)

	НовыйЗаголовок = Строка(Новый УникальныйИдентификатор);
	ВнешняяКомпонента.НачатьВызовУстановитьЗаголовок(Новый ОписаниеОповещения, ДескрипторОкна, НовыйЗаголовок);
	
КонецПроцедуры

&НаКлиенте
Процедура Активировать(Команда)
	
	ВнешняяКомпонента.НачатьВызовАктивироватьОкно(Новый ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура Распахнуть(Команда)

	ВнешняяКомпонента.НачатьВызовРаспахнутьОкно(Новый ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура Свернуть(Команда)
	
	ВнешняяКомпонента.НачатьВызовСвернутьОкно(Новый ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура Развернуть(Команда)

	ВнешняяКомпонента.НачатьВызовРазвернутьОкно(Новый ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиКлиентТестирования(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученКлиентТестирования", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовНайтиКлиентТестирования(ОписаниеОповещения, ПортПодключения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученКлиентТестирования(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	ДескрипторОкна = 0;
	СвойстваОбъекта.Очистить();
	Данные = ПрочитатьСтрокуJSON(РезультатВызова);
	Если ТипЗнч(Данные) = Тип("Структура") Тогда
		Данные.Свойство("ProcessId", ИдентификаторПроцесса);
		Данные.Свойство("Window", ДескрипторОкна);
		Данные.Свойство("Title", ЗаголовокОкна);
		Для каждого КлючЗначение из Данные Цикл
			НоваяСтр = СвойстваОбъекта.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтр, КлючЗначение);
		КонецЦикла;
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаСвойстваОбъекта;
	Иначе 
		ИдентификаторПроцесса = Неопределено;
		ДескрипторОкна = Неопределено;
		ЗаголовокОкна = Неопределено;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьСвойстваОкна(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученыСвойстваОбъекта", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСвойстваОкна(ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьРазмерОкна(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученыСвойстваОбъекта", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьРазмерОкна(ОписаниеОповещения, ДескрипторОкна);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьОкнаПроцесса(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСписокОконПроцесса", ЭтотОбъект);
	ВнешняяКомпонента.НачатьВызовПолучитьСписокОкон(ОписаниеОповещения, ИдентификаторПроцесса);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученСписокОконПроцесса(РезультатВызова, ПараметрыВызова, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(РезультатВызова);
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		СписокОкон.Очистить();
		Для каждого Стр из Данные Цикл
			ЗаполнитьЗначенияСвойств(СписокОкон.Добавить(), Стр);
		КонецЦикла;
	КонецЕсли;
	
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаСписокОкон;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьСписокДисплеев(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученСписокДисплеев", ЭтотОбъект);
	ВнешняяКомпонента.НачатьПолучениеСписокДисплеев(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученСписокДисплеев(Значение, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(Значение);
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		СписокДисплеев.Очистить();
		Для каждого Стр из Данные Цикл
			НоваяСтр = СписокДисплеев.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтр, Стр);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьСвойстваЭкрана(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученыСвойстваЭкрана", ЭтотОбъект);
	ВнешняяКомпонента.НачатьПолучениеСвойстваЭкрана(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученыСвойстваЭкрана(Значение, ДополнительныеПараметры) Экспорт
	
	Данные = ПрочитатьСтрокуJSON(Значение);
	Если ТипЗнч(Данные) = Тип("Структура") Тогда
		СвойстваОбъекта.Очистить();
		Для каждого КлючЗначение из Данные Цикл
			Если ТипЗнч(КлючЗначение.Значение) = Тип("Структура") Тогда
				Для каждого КЗ из КлючЗначение.Значение Цикл
					НоваяСтр = СвойстваОбъекта.Добавить();
					НоваяСтр.Ключ = КлючЗначение.Ключ + "." + КЗ.Ключ;
					НоваяСтр.Значение = КЗ.Значение;
				КонецЦикла;
			Иначе
				ЗаполнитьЗначенияСвойств(СвойстваОбъекта.Добавить(), КлючЗначение);
			КонецЕсли;
		КонецЦикла;
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаСвойстваОбъекта;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьТекстИзБуфера(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученТекстБуфераОбмена", ЭтотОбъект);
	БуферОбмена.НачатьПолучениеТекст(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура КопироватьТекстВБуфер(Команда)
	
	БуферОбмена.НачатьУстановкуТекст(, ТекстБуфераОбмена);

КонецПроцедуры

&НаКлиенте
Процедура ПолученТекстБуфераОбмена(Значение, ДополнительныеПараметры) Экспорт
	
	ТекстБуфераОбмена = Значение;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьКартинкуИзБуфера(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученаКартинкаБуфераОбмена", ЭтотОбъект);
	БуферОбмена.НачатьПолучениеКартинка(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученаКартинкаБуфераОбмена(Значение, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
		ДанныеКартинки = ПоместитьВоВременноеХранилище(Значение, УникальныйИдентификатор);
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаКартинка;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура КопироватьКартинкуВБуфер(Команда)
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(КартинкаЛоготип1С);
	БуферОбмена.НачатьУстановкуКартинка(, ДвоичныеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ФорматБуфераОбмена(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ПолученФорматБуфераОбмена", ЭтотОбъект);
	БуферОбмена.НачатьПолучениеФормат(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученФорматБуфераОбмена(Значение, ДополнительныеПараметры) Экспорт
	
	ФорматБуфераОбмена.Очистить();
	Данные = ПрочитатьСтрокуJSON(Значение);
	Если ТипЗнч(Данные) = Тип("Массив") Тогда
		Для каждого Стр из Данные Цикл
			НоваяСтр = ФорматБуфераОбмена.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтр, Стр);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ОчиститьБуферОбмена(Команда)

	БуферОбмена.НачатьВызовОчистить(Новый ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьТекст(Команда)
	
	ТекстБуфераОбмена = Формат(ТекущаяДата(), "ДЛФ=DDT");
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТекст(Команда)
	
	ТекстБуфераОбмена = Неопределено;
	
КонецПроцедуры

&НаКлиенте
Процедура КопироватьСнимокВБуферОбмена(Команда)

	Если ПустаяСтрока(ДанныеКартинки) Тогда Возврат КонецЕсли;
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(ДанныеКартинки);
	БуферОбмена.НачатьУстановкуКартинка(, ДвоичныеДанные);
	
КонецПроцедуры

