﻿#Область ПроцедурыФормы

	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		Объект.Дата = ТекущаяДата();
		СложитьВсе();
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыРеквизитовФормы

	&НаКлиенте
	Процедура СложитьВсе()
		Объект.СуммаДокумента = Объект.РасходныеДетали.Итог("Сумма")+Объект.ОсновныеДетали.Итог("Цена");
		Объект.КолДеталей = Объект.РасходныеДетали.Итог("Количество")+Объект.ОсновныеДетали.Количество();
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыТабличнойЧастиРасходныеДетали

	&НаКлиенте
	Процедура СуммаРасходныхСредств()
		ТД = Элементы.Комплектующие.ТекущиеДанные;
		Если Элементы.КомплектующиеКоличествоКоробок.Видимость Тогда
			ТД.Сумма = ТД.Цена*ТД.КоличествоКоробок;
		Иначе
			ТД.Сумма = ТД.Цена*ТД.Количество;
		КонецЕсли;
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеЦенаПриИзменении(Элемент)
		СуммаРасходныхСредств();
		СложитьВсе();
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеКоличествоПриИзменении(Элемент)
		СуммаРасходныхСредств();	
		СложитьВсе();
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеСуммаПриИзменении(Элемент)
		СложитьВсе();
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеПослеУдаления(Элемент)
		СложитьВсе()
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеЕдИзмПриИзменении(Элемент)
		ТД = Элементы.Комплектующие.ТекущиеДанные;
		Если ТД.ЕдИзм = ПолучитьПеречисленияВУпаковке() тогда
			Элементы.КомплектующиеКоличествоКоробок.Видимость = истина;
			Элементы.КомплектующиеВУпаковке.Видимость = истина;
			Элементы.КомплектующиеКоличество.Заголовок = "Общее количество";
			Элементы.КомплектующиеКоличество.ТолькоПросмотр = Истина;
		Иначе 
			Элементы.КомплектующиеКоличествоКоробок.Видимость = ложь;
			Элементы.КомплектующиеВУпаковке.Видимость = ложь;
			Элементы.КомплектующиеКоличество.Заголовок = "Количество";
			Элементы.КомплектующиеКоличество.ТолькоПросмотр = ложь;
		КонецЕсли;		
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеКоличествоКоробокПриИзменении(Элемент)
		ТД = Элементы.Комплектующие.ТекущиеДанные;
		ТД.Количество = ТД.КоличествоКоробок*ТД.ВУпаковке;
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеВУпаковкеПриИзменении(Элемент)
		ТД = Элементы.Комплектующие.ТекущиеДанные;
		ТД.Количество = ТД.КоличествоКоробок*ТД.ВУпаковке;
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыТабличнойЧастиОсновныеДетали

&НаКлиенте
Процедура КомплектующиеСирийныйНомерПриИзменении(Элемент)
	//ТД = Элементы.Комплектующие.ТекущиеДанные;
	//Если ТД.Количество >1 тогда
	//	ТД.СерийныйНомер = "";
	//	Сообщить("Более одной детали с одинаковым серийным номером не может быть!");
	//КонецЕсли;
КонецПроцедуры

	&НаКлиенте
	функция ПроверкаНаПовторы(ТД)
		Для Индекс = 0 по Объект.ОсновныеДетали.Количество() - 2 цикл
			Строка = Объект.ОсновныеДетали.Получить(Индекс);
			Если ТД.Деталь = Строка.Деталь и ТД.СерийныйНомер = Строка.СерийныйНомер тогда
				Возврат Индекс+1;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Возврат 0;	
	КонецФункции

	&НаКлиенте
	Процедура ОсновныеДетали1ЦенаПриИзменении(Элемент)
		СложитьВсе();
	КонецПроцедуры

	&НаКлиенте
	Процедура ОсновныеДетали1ДетальПриИзменении(Элемент)
		СложитьВсе();
		ТД = Элементы.ОсновныеДетали1.ТекущиеДанные;
		НомерСтрокиСПовтором = ПроверкаНаПовторы(ТД);
		если НомерСтрокиСПовтором > 0 тогда
			Сообщить("Деталь "+ТД.Деталь+" с номером "+ТД.СерийныйНомер+" уже прописана в этом документе под номером "+НомерСтрокиСПовтором+".");
			ТД.Деталь = "";
		КонецЕсли;
	КонецПроцедуры

	&НаКлиенте
	Процедура ОсновныеДетали1СерийныйНомерПриИзменении(Элемент)
		ТД = Элементы.ОсновныеДетали1.ТекущиеДанные;
		НомерСтрокиСПовтором = ПроверкаНаПовторы(ТД);
		если НомерСтрокиСПовтором>0 тогда
			Сообщить("Деталь "+ТД.Деталь+" с номером "+ТД.СерийныйНомер+" уже прописана в этом документе под номером "+НомерСтрокиСПовтором+".");
			ТД.СерийныйНомер = "";
		КонецЕсли;
	КонецПроцедуры

	&НаКлиенте
	Процедура ОсновныеДетали1ПослеУдаления(Элемент)
		СложитьВсе()
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

	//Получить перечисление единицы измерения
	&НаСервере
	функция ПолучитьПеречисленияВУпаковке()
		Возврат Перечисления.ЕдиницыИзмерения.упаковка;
	КонецФункции

#КонецОбласти