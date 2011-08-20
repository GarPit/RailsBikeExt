# -*- coding: utf-8 -*-
Пусть /^мы имеем интегратор \- сингелтон$/ do
  @integrator = RailsbikeExt::Integrator.instance
end

Пусть /^он не является неопределенным$/ do
  RailsbikeExt::Integrator.instance.should_not be(nil)
end

То /^у него должно быть (\d+) или больше расширений$/ do |arg1|
  RailsbikeExt::Integrator.instance.engines.should_not be_empty
end