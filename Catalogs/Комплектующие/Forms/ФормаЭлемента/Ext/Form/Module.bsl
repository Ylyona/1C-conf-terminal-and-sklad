﻿#Область ПроцедурыФормы

	&НаКлиенте
	Процедура ПриЗакрытии(ЗавершениеРаботы)
		
	КонецПроцедуры

	&НаКлиенте
	Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
		
	КонецПроцедуры

	&НаКлиенте
	Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
		Объект.Наименование = ПолучитьНаименование(Объект.Тип)+", "+ПолучитьНаименование(Объект.Марка)+", "+ПолучитьНаименование(Объект.Модель);
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

	&НаСервере
	Функция ПолучитьНаименование(Объект)
		Возврат Объект.Наименование;
	КонецФункции

#КонецОбласти