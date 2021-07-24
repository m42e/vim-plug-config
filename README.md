# vim-plug-config

A simple plugin which allows to manage the configuration per plugin in combination with vim.plug.
The advantage is, that it will load configs automatically if available and the plugin is loaded. Works also with lazy loaded plugins.

## Configuration

You have to define at lease path where configs are located. All the paths will be searched, new configs will be created in the first path.

```vim
let g:plug_config_dirs = ['~/.nvim/pluginconfigs', '~/git/vim-plugin-configs']
```

## Create or Edit

Just call `PlugConfig <pluginname>` and it will either open an existing one (first one found) or it will create one in the first directory. Autocomplete is supported, too.

