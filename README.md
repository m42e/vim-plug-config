# vim-plug-config

A simple plugin which allows to manage the configuration per plugin in combination with [vim-plug](https://github.com/junegunn/vim-plug).
The advantage is, that it will load configs automatically if available and the plugin is loaded. Works also with lazy loaded plugins.

## Configuration

You have to define at lease path where configs are located. All the paths will be searched, new configs will be created in the first path.

```vim
let g:plug_config_dirs = ['~/.nvim/pluginconfigs', '~/git/vim-plugin-configs']
```

Place this configuration before the `plug#begin()`

## Create or Edit

Just call `PlugConfig <pluginname|'bindings'>` and it will either open an existing one (first one found) or it will create one in the first directory. Autocomplete is supported, too.

`binding` is a special one, it will always be present and loaded if the file exists, regardless of the existence of a plugin named like this. It can be used to have bindings/mapping which trigger the loading of a plugin. In my case it contains `<leader>n :NERDTreeFocus<CR>` for example.



## Installation

Simple as you already know

```
Plug 'm42e/vim-plug-config
```

Add it as last plugin, to be sure the plugins are all loaded before the config is.
