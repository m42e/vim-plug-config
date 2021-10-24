if exists("g:vim_plug_config") || &cp || v:version < 700
    finish
endif
let g:vim_plug_config = 1

function! s:get_plugin_names()
  return keys(g:plugs) + ['bindings']
endfunction

function! s:get_config_path(name, create)
  " uniform name, remove vim prefix
  let l:pluginconfig = tolower(a:name).'.vim'
  if !exists('s:config_dirs')
    let s:config_dirs = get(g:, 'plug_config_dirs', [split(&rtp, ',')[0] . '/configs'])
  endif
  " look in paths for file, else use first one as default
  for path in s:config_dirs
    let l:file = glob(path.'/'.l:pluginconfig)
    if filereadable(l:file)
      return l:file
    endif
  endfor
  if a:create && len(s:config_dirs) > 0
    if !isdirectory(s:config_dirs[0])
      try
        call mkdir(s:config_dirs[0], 'p')
      catch
        return ''
      endtry
    endif
    return s:config_dirs[0].'/'.l:pluginconfig
  else
    return ''
  endif
endfunction

function! s:edit_config(name)
  let l:file = s:get_config_path(a:name, 1)
  exe 'tabedit ' . l:file
endfunction

function! s:load_config(name)
  let l:file = s:get_config_path(a:name, 0)
  if l:file != '' && filereadable(l:file)
    exe 'source ' . l:file
    let g:plugs_configs[a:name] = l:file
  endif
endfunction

function! s:load_all_configs()
  let g:plugs_configs = {}
  for plug in s:get_plugin_names()
    if has_key(g:plugs, plug) && ( has_key(g:plugs[plug], 'on') || has_key(g:plugs[plug], 'for') )
      execute 'autocmd User ' . plug . ' call s:load_config("' . plug . '")'
    else
      call s:load_config(plug)
    endif
  endfor
endfunction

function! s:names(...)
  return sort(filter(s:get_plugin_names(), 'stridx(v:val, a:1) == 0'))
endfunction

call s:load_all_configs()

command! -nargs=1 -bar -complete=customlist,s:names PlugConfig call s:edit_config(<f-args>)
