﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр ДвижениеОсновныхДеталей
	Движения.ДвижениеОсновныхДеталей.Записывать = Истина;
	Для Каждого ТекСтрокаОсновныеДетали Из ОсновныеДетали Цикл
		Движение = Движения.ДвижениеОсновныхДеталей.Добавить();
		Движение.Период = Дата;
		Движение.Деталь = ТекСтрокаОсновныеДетали.ДетальПередатьМенедж;
		Движение.Статус = Перечисления.СтатусДетали.ВЗапас;
		Движение.Менеджер = НовыйМенеджер;
		Движение.Комментарий = Комментарий;
		Если ИсточникПоступленияМенеджеру = Перечисления.СтатусДетали.Используется тогда
			Движение.Исполнитель = НовыйМенеджер;
		ИначеЕсли ИсточникПоступленияМенеджеру = Перечисления.СтатусДетали.ВЗапас тогда
			Движение.Исполнитель = Менеджер;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ИсточникПоступленияМенеджеру = Перечисления.СтатусДетали.Используется тогда
	// регистр Используется Расход
		Движения.Используется.Записывать = Истина;
		Для Каждого ТекСтрокаРасходныеДеталиВЗапас Из РасходныеДеталиВЗапас Цикл
			Движение = Движения.Используется.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ДетальРасх = ТекСтрокаРасходныеДеталиВЗапас.ДетальПередатьМенедж;
			Движение.ТерминалРасх = Терминал;
			Движение.КоличествоРасх = ТекСтрокаРасходныеДеталиВЗапас.КоличествоПередатьРасхДет;
			Движение.ИсполнительРасхИсп = Менеджер;
			Движение.КомментарийРасхИсп = Комментарий;
		КонецЦикла;
	
	ИначеЕсли ИсточникПоступленияМенеджеру = Перечисления.СтатусДетали.НаСкладе тогда
	// регистр НаСклад Расход
		Движения.НаСклад.Записывать = Истина;
		Для Каждого ТекСтрокаРасходныеДеталиВЗапас Из РасходныеДеталиВЗапас Цикл
			Движение = Движения.НаСклад.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ДетальРасхНаСклад = ТекСтрокаРасходныеДеталиВЗапас.ДетальПередатьМенедж;
			Движение.КоличествоРасхНаСклад = ТекСтрокаРасходныеДеталиВЗапас.КоличествоПередатьРасхДет;
			Движение.ИсполнительРасхНаСклад = Менеджер;
			Движение.КомментарийРасхНаСклад = Комментарий;
		КонецЦикла;
	КонецЕсли;

	// регистр ВЗапас Приход
	Движения.ВЗапас.Записывать = Истина;
	Для Каждого ТекСтрокаРасходныеДеталиВЗапас Из РасходныеДеталиВЗапас Цикл
		Движение = Движения.ВЗапас.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.ДетальРасхЗапас = ТекСтрокаРасходныеДеталиВЗапас.ДетальПередатьМенедж;
		Движение.МенеджерРасхЗапас = НовыйМенеджер;
		Движение.КоличествоРасхЗапас = ТекСтрокаРасходныеДеталиВЗапас.КоличествоПередатьРасхДет;
		Движение.ИсполнительРасхЗапас = Менеджер;
		Движение.КомментарийРасхЗапас = Комментарий;
	КонецЦикла;


	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
