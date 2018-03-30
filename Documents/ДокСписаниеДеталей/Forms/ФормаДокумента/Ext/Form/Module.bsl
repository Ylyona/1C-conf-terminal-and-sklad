﻿#Область ПроцедурыФормы

	//Проверяем что выбрано в статусе и отображаем нужные элементы, не нужные не отображаем и очищаем
	&НаКлиенте
	Процедура ПодготовкаФормы()
		//Получаем нужные значения перечисления с сервера, что бы понять что имено мы выбрали в источнике
		ПеречислНИ = ПолучитьПеречислениеНеисправно();
		ПеречислНР = ПолучитьПеречислениеНаРемонте();
		ПеречислИсп = ПолучитьПеречислениеИспользуется();

		Если Объект.ИсточникПоступленияНаСклад = ПеречислНИ или  Объект.ИсточникПоступленияНаСклад.Пустая() Тогда
			Объект.Терминал = ПолучитьПустуюСсылкуМенеджера();
			Элементы.Менеджер.Заголовок = Элементы.Менеджер.Имя;
			Элементы.Менеджер.Видимость = Ложь;
		
			Объект.СервисныйПункт = ПолучитьПустуюСсылкуКонтрагента();
			Элементы.СервисныйПункт.Видимость = Ложь;
		
			Объект.Терминал = ПолучитьПустуюСсылкуТерминала();
			Элементы.Терминал.Видимость = Ложь;
				
		ИначеЕсли Объект.ИсточникПоступленияНаСклад = ПеречислИсп тогда
		
			Элементы.Терминал.Видимость = Истина;
		
			Объект.СервисныйПункт = ПолучитьПустуюСсылкуКонтрагента();
			Элементы.СервисныйПункт.Видимость = Ложь;
			
			Объект.Менеджер = ПолучитьПустуюСсылкуМенеджера();
			Элементы.Менеджер.Заголовок = "Исполнитель";
			Элементы.Менеджер.Видимость = Истина;
		
		ИначеЕсли Объект.ИсточникПоступленияНаСклад = ПеречислНР тогда
		
			Элементы.СервисныйПункт.Видимость = Истина;
				
			Объект.Терминал = ПолучитьПустуюСсылкуТерминала();
			Элементы.Терминал.Видимость = Ложь;
			
			Объект.Менеджер = ПолучитьПустуюСсылкуМенеджера();
			Элементы.Менеджер.Видимость = Ложь;
				
		КонецЕсли;
	КонецПроцедуры

	//Если при открытии формы источник детали уже указан меняем форму
	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		Объект.Дата = ТекущаяДата();
		ПодготовкаФормы();
	КонецПроцедуры

	&НаКлиенте
	Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
		Если  Элементы.Менеджер.Видимость = Истина и Объект.Менеджер.Пустая() и Элементы.Терминал.Видимость = ложь тогда
			Отказ = истина;
			Сообщить("Укажите менеджера!");
		ИначеЕсли (Элементы.Терминал.Видимость = Истина или Элементы.Менеджер.Видимость = Истина) и (Объект.Терминал.Пустая() или Объект.Менеджер.Пустая()) тогда
			Отказ = истина;
			Сообщить("Укажите Менеджера и/или Терминал!");
		ИначеЕсли Элементы.СервисныйПункт.Видимость = Истина и Объект.СервисныйПункт.Пустая() тогда
			Отказ = истина;
			Сообщить("Укажите Сервисный пункт!");
		Иначе 
			Отказ = ложь;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыРеквизитовФормы

	//Меняем форму в соответствии с изменившимся статусом
	&НаКлиенте
	Процедура ИсточникПоступленияНаСкладПриИзменении(Элемент)
		ПодготовкаФормы();	
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыТабличнойЧастиРасходныеДетали

	&НаКлиенте
	Процедура РасходныеДетали1ДетальРасхСписНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		СтандартнаяОбработка = ложь;
		Источник = Объект.ИсточникПоступленияНаСклад;
		Если Источник = ПолучитьПеречислениеНеисправно() или не Объект.Менеджер.Пустая() или не Объект.Терминал.Пустая() или не Объект.СервисныйПункт.Пустая() тогда
			Если Источник = ПолучитьПеречислениеНаРемонте() тогда
				ДанныеВыбора = ПолучениеДеталейИзРегистровНакопления(Источник, Объект.СервисныйПункт);
			ИначеЕсли Источник = ПолучитьПеречислениеНеисправно() тогда
				ДанныеВыбора = ПолучениеДеталейИзРегистровНакопления(Источник, "");
			ИначеЕсли Источник = ПолучитьПеречислениеИспользуется() тогда
				ДанныеВыбора = ПолучениеДеталейИзРегистровНакопления(Источник, Объект.Терминал);
			КонецЕсли;
		Иначе
			Сообщить("Не верно заполнены данные!!!");
		КонецЕсли;
КонецПроцедуры

	&НаКлиенте
	Процедура РасходныеДетали1ДетальРасхСписПриИзменении(Элемент)
		ТД = Элементы.РасходныеДетали1.ТекущиеДанные;
		Источник = Объект.ИсточникПоступленияНаСклад;
		Если Источник = ПолучитьПеречислениеНеисправно()или не Объект.Менеджер.Пустая() или не Объект.Терминал.Пустая() или не Объект.СервисныйПункт.Пустая() тогда
			Если Источник = ПолучитьПеречислениеНеисправно() тогда
				ЗначИзмер = "";
			ИначеЕсли Источник = ПолучитьПеречислениеНаРемонте() тогда
				ЗначИзмер = Объект.СервисныйПункт;
			ИначеЕсли Источник = ПолучитьПеречислениеИспользуется() тогда
				ЗначИзмер = Объект.Терминал;
			КонецЕсли;
			ТД.КоличествоДостРасхСпис = ПолучитьКоличествоДеталей(Объект.Дата,Источник,ТД.ДетальРасхСпис,ЗначИзмер);
		
			Коммент = ПолучитьНеиспрРасхДеталей(Объект.Дата, ТД.ДетальРасхСпис);
			ТД.НеисправностьРасхСпис = Коммент;
		Иначе
			Сообщить("Не верно заполнены данные!!!");
		КонецЕсли;
	КонецПроцедуры

	&НаКлиенте
	Процедура РасходныеДетали1КоличествоРасхСписПриИзменении(Элемент)
		ТД1 = Элементы.РасходныеДетали1.ТекущиеДанные;
		Ошибка = Ложь;
		Если ТД1.КоличествоДостРасхСпис < ТД1.КоличествоРасхСпис тогда
			ТД1.КоличествоРасхСпис = 0;
			Сообщить("Данного количества детали "+ТД1.ДетальРасхСпис+" нет в наличии");
			Ошибка = Истина;
		КонецЕсли;
		Если Ошибка = Ложь Тогда
			ОбщееКоличествоОдинаковыхРасходныхДеталей = ТД1.КоличествоРасхСпис;
			Для Индекс = 0 По Объект.РасходныеДетали.Количество()-2 Цикл
				Если ТД1.ДетальРасхСпис = Объект.РасходныеДетали.Получить(Индекс).ДетальРасхСпис Тогда
					ОбщееКоличествоОдинаковыхРасходныхДеталей = ОбщееКоличествоОдинаковыхРасходныхДеталей + Объект.РасходныеДетали.Получить(Индекс).КоличествоРасхСпис;
					Если ТД1.КоличествоДостРасхСпис < ОбщееКоличествоОдинаковыхРасходныхДеталей Тогда
						ТД1.КоличествоРасхСпис = 0;
						Сообщить("Данного количества детали "+ТД1.ДетальРасхСпис+" нет в наличии, пороверьте предыдущие строки");
						Прервать;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыТабличнойЧастиОсновныеДетали

	&НаКлиенте
	Процедура ОсновныеДетали1ДетальПриемНаСклНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		СтандартнаяОбработка = ложь;
		//Получаем список деталей которые соответствует выбранному статусу и выводим его в список выбора
		Источник = Объект.ИсточникПоступленияНаСклад;
		Если Источник = ПолучитьПеречислениеНеисправно() или не Объект.Менеджер.Пустая() или не Объект.Терминал.Пустая() или не Объект.СервисныйПункт.Пустая() тогда
			Если Источник = ПолучитьПеречислениеНеисправно() тогда
				ДанныеВыбора = ФункцииДеталей.ПолучениеОсновныхДеталей(Источник);
			ИначеЕсли Источник = ПолучитьПеречислениеНаРемонте() тогда
				ДанныеВыбора = ФункцииДеталей.ПолучениеОсновныхДеталей(Источник, "СервисТочка", Объект.СервисныйПункт);
			ИначеЕсли Источник = ПолучитьПеречислениеИспользуется() тогда
				ДанныеВыбора = ФункцииДеталей.ПолучениеОсновныхДеталей(Источник, "Терминал", Объект.Терминал);
			КонецЕсли;
		Иначе
			Сообщить("Не верно заполнены данные!!!");
		КонецЕсли;
	КонецПроцедуры

	&НаКлиенте
	Процедура ОсновныеДетали1ДетальПриемНаСклПриИзменении(Элемент)
		ТД =  Элементы.ОсновныеДетали1.ТекущиеДанные;
		Для Индекс = 0 По Объект.ОсновныеДетали.Количество()-2 Цикл
			Если ТД.ДетальПриемНаСкл = Объект.ОсновныеДетали.Получить(Индекс).ДетальПриемНаСкл Тогда
				ТД.ДетальПриемНаСкл = получитьПустуюСсылкуОснДет();
				Сообщить("Основная деталь выбрана повторно");
				Прервать;
			КонецЕсли;
		КонецЦикла;
		ТД.КомментарийТЧ = ПолучитьНеиспрОснДеталей(Объект.Дата, ТД.ДетальПриемНаСкл);
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

&НаСервере
Функция получитьПустуюСсылкуОснДет();
	Возврат Справочники.ОсновныеСредства.ПустаяСсылка();
КонецФункции

&НаСервере
Функция ПолучитьНеиспрОснДеталей(Дата, Деталь)
	Отбор = новый структура;
	
		Отбор.Вставить("Деталь", Деталь);;
		Данные = РегистрыСведений.ДвижениеОсновныхДеталей.СрезПоследних(Дата, Отбор);
		Комментарий = Данные.ВыгрузитьКолонку("Комментарий");
		Список = новый СписокЗначений;
		Список.ЗагрузитьЗначения(Комментарий);
 
	Возврат Список;
КонецФункции

&НаСервере
Функция ПолучитьНеиспрРасхДеталей(Дата, Деталь)
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Неисправно.КомментарийРасхНаСклад КАК КомментарийРасхНаСклад
	|ИЗ
	|	РегистрНакопления.Неисправно КАК Неисправно
	|ГДЕ
	|	Неисправно.Период < &Период
	|	И Неисправно.ДетальРасхНаРем = &ДетальРасхНаРем
	|
	|УПОРЯДОЧИТЬ ПО
	|	Неисправно.Период");

	Запрос.УстановитьПараметр("ДетальРасхНаРем", Деталь); // Деталь.
	Запрос.УстановитьПараметр("Период", Дата); // Дата.

	Комментарий = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("КомментарийРасхНаСклад");
	Список = Новый СписокЗначений;
	Список.ЗагрузитьЗначения(Комментарий);
	//Сообщить("Количество полученных значений = "+Список.Количество());
	Возврат Список;

КонецФункции

//Следующие функции нужны для правильной отчистки полей которые должны быть не видему на форме

//Получить пустуюссылку Сервисный пункт
&НаСервере
Функция ПолучитьПустуюСсылкуКонтрагента()
	Возврат Справочники.Контрагенты.ПустаяСсылка();
КонецФункции

&НаСервере
Функция ПолучитьПустуюСсылкуТерминала()
	Возврат Справочники.Терминалы.ПустаяСсылка();
КонецФункции

&НаСервере
Функция ПолучитьПустуюСсылкуМенеджера()
	 Возврат Справочники.Менеджеры.ПустаяСсылка();
КонецФункции

//Следующие функции нужны что бы с сервера получать выбранные перечисления
&НаСервере
Функция ПолучитьПеречислениеНеисправно()
	Возврат Перечисления.СтатусДетали.Неисправно;
КонецФункции

&НаСервере
Функция ПолучитьПеречислениеИспользуется()
	Возврат Перечисления.СтатусДетали.Используется;
КонецФункции

&НаСервере
Функция ПолучитьПеречислениеНаРемонте()
	Возврат Перечисления.СтатусДетали.НаРемонте;
КонецФункции

&НаСервере
Функция ПолучениеДеталейИзРегистровНакопления(Статус, ЗначениеРесурса)

	
	Запрос = Новый Запрос;
	Если Статус = ПолучитьПеречислениеИспользуется() тогда
		Запрос.Текст = "ВЫБРАТЬ
		               |	ИспользуетсяОстатки.ДетальРасх КАК Деталь,
		               |	ИспользуетсяОстатки.КоличествоРасхОстаток КАК Количество
		               |ИЗ
		               |	РегистрНакопления.Используется.Остатки КАК ИспользуетсяОстатки
		               |ГДЕ
		               |	ИспользуетсяОстатки.ТерминалРасх = &ЗначениеРесурса";
	ИначеЕсли Статус = ПолучитьПеречислениеНаРемонте() тогда
		Запрос.Текст = "ВЫБРАТЬ
		               |	НаРемонтОстатки.ДетальРасхНаРем КАК Деталь,
		               |	НаРемонтОстатки.КоличествоРасхНаСкладОстаток КАК Количество
		               |ИЗ
		               |	РегистрНакопления.НаРемонт.Остатки КАК НаРемонтОстатки
		               |ГДЕ
		               |	НаРемонтОстатки.СервисныйПунктРасх = &ЗначениеРесурса";
					   
	ИначеЕсли Статус = ПолучитьПеречислениеНеисправно() тогда
		Запрос.Текст = "ВЫБРАТЬ
		               |	НеисправноОстатки.ДетальРасхНаРем КАК Деталь,
		               |	НеисправноОстатки.КоличествоРасхНаСкладОстаток КАК Количество
		               |ИЗ
		               |	РегистрНакопления.Неисправно.Остатки КАК НеисправноОстатки";

	КонецЕсли;

	Запрос.УстановитьПараметр("ЗначениеРесурса", ЗначениеРесурса);
	//Сохраняем результат запроса
	Результат = Запрос.Выполнить();
	//Преобразуем резултат в таблицу
	Таблица = Результат.Выгрузить();
	//Переводим таблицу в массив
	МассивДеталей = Таблица.ВыгрузитьКолонку("Деталь");
	МассивКоличествДеталей = Таблица.ВыгрузитьКолонку("Количество");
	//Создаём список значений
	Список = Новый СписокЗначений;
	//Загружаем список значений
	Если МассивДеталей.Количество() > 0 Тогда
		Для ИндексМассива = 0 По МассивДеталей.Количество() - 1 Цикл
			Список.Добавить(МассивДеталей[ИндексМассива],МассивДеталей[ИндексМассива].Наименование+", "+МассивКоличествДеталей[ИндексМассива]);
		КонецЦикла;
	Иначе
		Список.Добавить(Справочники.Комплектующие.ПустаяСсылка(), "Нет деталей");
	КонецЕсли;
	//Возвращаем список значений на клиент
	Возврат Список;
КонецФункции

&НаСервере
Функция ПолучитьКоличествоДеталей(Дата, Статус, Деталь, ЗначениеИзмерения);
	Отбор = новый структура;
	Если Статус = ПолучитьПеречислениеНеисправно() тогда
		Отбор.Вставить("ДетальРасхНаРем", Деталь);
		Данные = РегистрыНакопления.Неисправно.Остатки(Дата, Отбор);
		Количество = Данные.Итог("КоличествоРасхНаСклад");
	ИначеЕсли Статус = ПолучитьПеречислениеИспользуется() тогда
		Отбор.Вставить("ДетальРасх", Деталь);
		Отбор.Вставить("ТерминалРасх", ЗначениеИзмерения);
		Данные = РегистрыНакопления.Используется.Остатки(Дата,Отбор);
		Количество = Данные.Итог("КоличествоРасх");
	ИначеЕсли Статус = ПолучитьПеречислениеНаРемонте() тогда
		Отбор.Вставить("ДетальРасхНаРем", Деталь);
		Отбор.Вставить("СервисныйПунктРасх", ЗначениеИзмерения);
		Данные = РегистрыНакопления.НаРемонт.Остатки(Дата, Отбор);
		Количество = Данные.Итог("КоличествоРасхНаСклад");
	КонецЕсли;
 
	Возврат Количество;
КонецФункции

#КонецОбласти