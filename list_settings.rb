# -*- coding: utf-8 -*-

require_relative 'tab'

require 'gtk3'

Plugin.create :list_settings do
  this = self

  settings _("リスト") do
    add(this.setting_container)
  end

  # 設定のGtkウィジェット
  def setting_container
    tab = Plugin::ListSettings::Tab.new(self)
    available_lists.each{ |list|
      iter = tab.model.append
      iter[Plugin::ListSettings::Tab::SLUG] = list[:full_name]
      iter[Plugin::ListSettings::Tab::LIST] = list
      iter[Plugin::ListSettings::Tab::NAME] = list[:name]
      iter[Plugin::ListSettings::Tab::DESCRIPTION] = list[:description]
      iter[Plugin::ListSettings::Tab::PUBLICITY] = list[:mode] }
    Gtk::Box.new(:horizontal).add(tab).pack_start(tab.buttons(Gtk::Box), expand: false).show_all end

  # フォローしているリストを返す
  def available_lists
    Plugin.filtering(:following_lists, []).first
  end

end
