local q = xplr.util.shell_quote

local function setup()
  local xplr = xplr

  xplr.config.modes.custom.space_o_dir = {
    name = "space-o favorite directory mode",
    key_bindings = { on_key = {} },
  }

  directories_map = {
    ["A"] = "/Applications",
    ["b"] = "~/blog/",
    ["B"] = "~/bin/",
    ["C"] = "~/Cafe/",
    ["c"] = "~/.config/",
    ["C-c"] = "~/cascode/",
    ["d"] = "~/Downloads/",
    ["D"] = "~/Documents/",
    ["f"] = "~/.fzf/",
    ["g"] = "~/cascode/github.com/",
    ["H"] = "/home",
    ["h"] = "~/",
    ["i"] = "~/Library/Mobile Documents/com~apple~CloudDocs/",
    ["k"] = "~/kt/",
    ["l"] = "~/Library/Application Support/",
    ["L"] = "~/Library/Preferences/",
    ["M"] = "~/Movies/",
    ["m"] = "~/Documents/materials/",
    ["s"] = "~/Documents/materials/scratches/",
    ["S"] = "~/snips/",
    ["C-s"] = "~/Documents/materials/snippets",
    ["e"] = "~/.emacs.spacemacs.d",
    ["z"] = "~/.spacezsh/",
    ["Z"] = "~/.oh-my-zsh/",
    ["/"] = "/",
    ["o"] = "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org",
    ["j"] = "~/Documents/materials/journal",
    ["J"] = "~/Documents/materials/jira",
    ["n"] = "~/Documents/materials/notes",
    ["N"] = "~/Documents/evernotes",
    ["w"] = "~/Documents/materials/webclips",
    ["v"] = "/Volumes",
    ["T"] = "~/.tmux",
    ["t"] = "~/tmp/"
  }

  for k, v in pairs(directories_map) do
    local p = v
    if string.sub(v, 1, 1) == "~" then
      p = os.getenv("HOME") .. string.sub(v, 2)
    end
    xplr.config.modes.custom.space_o_dir.key_bindings.on_key[k] = {
      help = "open " .. p,
      messages = {
        { ChangeDirectory = p },
        "PopMode",
      }
    }
  end

  xplr.config.modes.custom.space_o = {
    name = "space-o mode",
    key_bindings = {
      on_key = {
        ["d"]= {
          help = "jump to favorite directory",
          messages = {
            "PopMode",
            { SwitchModeCustom = "space_o_dir" },
          },
        }
      }
    }
  }

  xplr.config.modes.custom.space = {
    name = "space mode",
    key_bindings = {
      on_key = {
        ["o"]= {
          help = "sapce-o",
          messages = {
            "PopMode",
            { SwitchModeCustom = "space_o" },
          },
        }
      }
    }
  }

  xplr.config.modes.builtin.default.key_bindings.on_key["space"] = {
    help = "space.xplr",
    messages = {
      "PopMode",
      { SwitchModeCustom = "space" },
    },
  }

  for i, k in ipairs({"ctrl-c", "ctrl-g", "esc"}) do
    for j, mode in ipairs({"space", "space_o", "space_o_dir"}) do
      xplr.config.modes.custom[mode].key_bindings.on_key[k] = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      }
    end
  end
end

return { setup = setup }
