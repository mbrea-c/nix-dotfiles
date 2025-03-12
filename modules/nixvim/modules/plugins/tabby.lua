require('tabby').setup({
  line = function(line)
    local theme = {
      fill = 'TabbyFill',
      head = 'TabbyHead',
      current_tab = 'TabbyCurrentTab',
      current_tab_sep = 'TabbyCurrentTabSep',
      tab = 'TabbyTab',
      tab_sep = 'TabbyTabSep',
      win = 'TabLine',
      tail = 'TabbyTail',
    }
    return {
      {
        { '𝕄 ', hl = theme.head },
        line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        local hl_sep = tab.is_current() and theme.current_tab_sep or theme.tab_sep
        return {
          line.sep('', hl_sep, theme.fill),
          tab.is_current() and '' or '󰆣',
          tab.number(),
          tab.name(),
          tab.close_btn(''),
          line.sep('', hl_sep, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep('', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      {
        line.sep('', theme.tail, theme.fill),
        { '  ', hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
})
