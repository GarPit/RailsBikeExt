# -*- coding: utf-8 -*-
# language: ru
@http://www.pivotaltracker.com/story/show/15813383
Функционал: Интегратор расширений
  Необходимо реализовать класс, который регистрирует расширения при запуске и сохраняет их в хэше для дальнейшего исопльзования в административном интерфейсе системы.

	Сценарий: Существование интегратора
		Пусть мы имеем интегратор - сингелтон
		И он не является неопределенным
		То у него должно быть 1 или больше расширений