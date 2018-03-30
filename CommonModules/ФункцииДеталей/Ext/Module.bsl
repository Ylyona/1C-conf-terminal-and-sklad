﻿// Функция - Получение списка основных деталей соответствующих указанному статусу и ресурсу регистра сведений при необходимости
//
// Параметры:
//  Статус	 - ПеречислениеСсылка.СтатусДетали 	 - Необходимый статус основных деталей
//  НазваниеРесурса	 - Строка	 - К примеру терминал
//  ЗначениеРесурса	 - Ссылка	 - К примеру ссылка на конкретный терминал
// 
// Возвращаемое значение:
//  СписокЗначений - Список значений основных деталей
//
&НаСервере
Функция ПолучениеОсновныхДеталей(Знач Статус, Знач НазваниеРесурса = Null, Знач ЗначениеРесурса = Null) Экспорт
	ИндексЗначения = Перечисления.СтатусДетали.Индекс(Статус);
	Список = Новый СписокЗначений;
	Если Не (НазваниеРесурса = Null и ЗначениеРесурса = Null) Тогда
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|ДвижениеОсновныхДеталейСрезПоследних.Деталь КАК Деталь 
		|ИЗ 
		|	РегистрСведений.ДвижениеОсновныхДеталей.СрезПоследних КАК ДвижениеОсновныхДеталейСрезПоследних 
		|ГДЕ 
		|	ДвижениеОсновныхДеталейСрезПоследних.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусДетали."+Метаданные.Перечисления.СтатусДетали.ЗначенияПеречисления[ИндексЗначения].Имя+")	
		|	И ДвижениеОсновныхДеталейСрезПоследних."+НазваниеРесурса+" = &ЗначениеРесурса");
		Запрос.УстановитьПараметр("ЗначениеРесурса", ЗначениеРесурса);
	ИначеЕсли Не НазваниеРесурса = Null и ЗначениеРесурса = Null Тогда
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|ДвижениеОсновныхДеталейСрезПоследних.Деталь КАК Деталь 
		|ИЗ 
		|	РегистрСведений.ДвижениеОсновныхДеталей.СрезПоследних КАК ДвижениеОсновныхДеталейСрезПоследних 
		|ГДЕ 
		|	ДвижениеОсновныхДеталейСрезПоследних.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусДетали."+Метаданные.Перечисления.СтатусДетали.ЗначенияПеречисления[ИндексЗначения].Имя+")");
	Иначе
		Список.Добавить(Справочники.ОсновныеСредства.ПустаяСсылка(), "Получены не все данные");
	КонецЕсли;
	//Сохраняем полученный массив основных деталей при выполнении запроса
	МассивДеталей = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Деталь");
	//Создаём список значений
	Список = Новый СписокЗначений;
	//Загружаем список значений
	Если МассивДеталей.Количество() > 0 Тогда
		Для ИндексМассива = 0 По МассивДеталей.Количество() - 1 Цикл
        	Список.Добавить(МассивДеталей[ИндексМассива],МассивДеталей[ИндексМассива].СерийныйНомерСправочник+", "+МассивДеталей[ИндексМассива].Наименование);
		КонецЦикла;
	Иначе
		Список.Добавить(Справочники.ОсновныеСредства.ПустаяСсылка(), "Нет деталей");
	КонецЕсли;
	//Возвращаем список значений на клиент
	Возврат Список;
КонецФункции