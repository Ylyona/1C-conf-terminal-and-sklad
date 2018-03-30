﻿#Область ПроцедурыФормы

	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		Объект.Дата = ТекущаяДата();
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыТабличнойЧастиДоходыСТерминалов

	&НаКлиенте
	Процедура ДоходыСТерминаловАрендаПриИзменении(Элемент)
		ТД = Элементы.ДоходыСТерминалов.ТекущиеДанные;
		Если КастыльТерм(ТД.Терминал) = ПолучитьПеречисление() тогда 
			ТД.СуммаДохода = ТД.Доход+ТД.Аренда;
		иначе 
			ТД.СуммаДохода = ТД.Доход-ТД.Аренда;
		КонецЕсли;
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ДоходыСТерминаловДоходПриИзменении(Элемент)
		ТД = Элементы.ДоходыСТерминалов.ТекущиеДанные;
		Если КастыльТерм(ТД.Терминал) = ПолучитьПеречисление() тогда 
			ТД.СуммаДохода = ТД.Доход+ТД.Аренда;
		иначе 
			ТД.СуммаДохода = ТД.Доход-ТД.Аренда;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область КомандыКнопок

	&НаКлиенте
	Процедура Заполнить(Команда)
		Объект.ДоходыСТерминалов.Очистить();
		ЗС = ЗаполнитьНаСервере();
		Для Каждого Терминал Из ЗС Цикл
			НоваяСтр = Объект.ДоходыСТерминалов.Добавить();
			НоваяСтр.Терминал = Терминал;
			Аренда = ПолучитьАренду(НоваяСтр.Терминал);
			НоваяСтр.Аренда = Аренда; 
		КонецЦикла;
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

&НаСервере
функция ЗаполнитьНаСервере()
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	|	ДвижениеТерминаловСрезПоследних.Терминал КАК Терминал
	|ИЗ
	|	РегистрСведений.ДвижениеТерминалов.СрезПоследних КАК ДвижениеТерминаловСрезПоследних
	|ГДЕ
	|	ДвижениеТерминаловСрезПоследних.Эксплуатация = &Эксплуатация");

	Запрос.УстановитьПараметр("Эксплуатация", Истина); 
	Массив = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Терминал");
	Возврат Массив;
	
КонецФункции

&НаСервере
функция ПолучитьДоговор(Терминал)
	Запрос = Новый Запрос(
						"ВЫБРАТЬ
						|	СвязиТерминаловИДоговоровСрезПоследних.ДействущийДоговор КАК ДействущийДоговор
						|ИЗ
						|	РегистрСведений.СвязиТерминаловИДоговоров.СрезПоследних КАК СвязиТерминаловИДоговоровСрезПоследних
						|ГДЕ
						|	СвязиТерминаловИДоговоровСрезПоследних.Терминал = &Терминал");

		Запрос.УстановитьПараметр("Терминал", Терминал); // Терминал

		РезультатЗапроса = Запрос.Выполнить();
		
		Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("ДействущийДоговор");
		
КонецФункции

&НаСервере
функция ПолучитьАренду(Терминал)
	СписокЗначений = новый СписокЗначений;
	СписокЗначений.ЗагрузитьЗначения(ПолучитьДоговор(Терминал));
	Для каждого Договор из СписокЗначений цикл
		Аренда = Договор.Значение.Стоимость;
	Конеццикла;
		
	Возврат Аренда;

	
конецфункции

&НаСервере
Функция ПолучитьЭлементСправочникаТерминалы(Значение)
	Возврат Справочники.Терминалы.НайтиПоНаименованию(Значение);	
КонецФункции

&НаСервере
Функция ПолучитьПеречисление()
	Возврат Перечисления.ВидКонтрагента.Арендаторы;
конецФункции

// 16.03.2018 ЗДЕСЬ!!!
&НаСервере
Функция КастыльТерм(Терминал)
	
	ТермОб = ПолучитьДоговор(Терминал)[0].Ссылка.ПолучитьОбъект();
	Возврат ТермОб.ОтноситсяКГрупе;
КонецФункции

&НаСервере
Функция ПолучитьСистемуМониторинг()
	//возврат Справочники.СистиемаМониторинга.НайтиПоНаименованию("Наименование");
КонецФункции

#КонецОбласти