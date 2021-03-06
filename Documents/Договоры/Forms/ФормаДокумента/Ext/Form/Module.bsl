﻿#Область ПроцедурыФормы

	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
			Объект.Дата = ПолучитьТекущуюДатуСеанса();
	КонецПроцедуры
	
	&НаСервере
	функция ПолучитьТекущуюДатуСеанса()
		Возврат ТекущаяДатаСеанса();
	КонецФункции

	
	&НаКлиенте
	Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
		Если Элементы.НомерПисьменногоДоговора.Видимость = истина и Объект.НомерПисьменногоДоговора = "" тогда
			Отказ = истина;
			Сообщить("Введите № письменного договора аренды");
		Иначе
			Отказ = ложь;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыРеквизитовФормы

	//ПеречислениеПисьменнаяФорма
	&НаСервере
	Функция ПолучитьПеречислениеПисьменное()
		возврат Перечисления.ФормаДоговора.ПисьменнаяФорма;
	КонецФункции


	&НаКлиенте
	Процедура КонтрагентПриИзменении(Элемент)
		Объект.ВЛице = КонтрагентПриИзмененииНаСервере(Объект.Контрагент);
	КонецПроцедуры
	
	&НаКлиенте
	Процедура ФормаДоговораПриИзменении(Элемент)
		ФД =Объект.ФормаДоговора;
		Если ФД = ПолучитьПеречислениеПисьменное() тогда
			Объект.НомерПисьменногоДоговора = "";
			Элементы.НомерПисьменногоДоговора.Видимость = истина;
		Иначе 
			Объект.НомерПисьменногоДоговора = "";
			Элементы.НомерПисьменногоДоговора.Видимость = Ложь;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

&НаСервере
Функция КонтрагентПриИзмененииНаСервере(Контрагент)
	Возврат Контрагент.РуководительКонтр;
КонецФункции


#КонецОбласти