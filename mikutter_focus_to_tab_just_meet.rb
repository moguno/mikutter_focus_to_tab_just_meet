#coding: utf-8

Plugin.create(:mikutter_focus_to_tab_just_meet) {

  # メソッド書き換え
  command_plugin = Plugin[:command]

  def command_plugin.focus_move_to_latest_widget(postbox)
    pane = if postbox.parent.is_a? Plugin::GUI::Window
      last_active_pane[postbox.parent.slug]
    else
      postbox.parent
    end

    if pane
      pane.active! 

      target = pane.active_chain.find { |_| _.is_a?(Plugin::GUI::Timeline) }

      if target
        target_widget = Plugin[:gtk].widgetof(target)

        if target_widget
          path = target_widget.visible_range[0]
          target_widget.set_cursor(path, nil, false)
        end
      end
    end
  end
}
