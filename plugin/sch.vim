function! <SID>SwitchFile(...)
    let l:opencmd = (a:0 >= 1 && a:1 == 's') ? 'sp ' : 'vs '
    let l:hdr_ext_set = ['h', 'hpp', 'hxx', 'hh', 'H']
    let l:src_ext_set = ['cc', 'cpp', 'cxx', 'c', 'C', 'inl']
    let l:root = expand('%:r')
    let l:ext = expand('%:e')
    if (index(l:hdr_ext_set, l:ext) >= 0)
        for new_ext in l:src_ext_set
            let l:new_fname = l:root . '.' . new_ext
            if filereadable(l:new_fname)
                let l:window_id = bufwinnr(l:new_fname)
                if l:window_id != -1
                    execute l:window_id . "wincmd w"
                else
                    execute l:opencmd . l:new_fname
                endif
                return
            endif
        endfor
        echomsg 'No file found!'
        return
    elseif (index(l:src_ext_set, l:ext) >= 0)
        for new_ext in l:hdr_ext_set
            let l:new_fname = l:root . '.' . new_ext
            if filereadable(l:new_fname)
                let l:window_id = bufwinnr(l:new_fname)
                if l:window_id != -1
                    execute l:window_id . "wincmd w"
                else
                    execute l:opencmd . l:new_fname
                endif
                return
            endif
        endfor
        echomsg 'No file found!'
        return
    else
        echomsg "Not supported file type"
    endif
endfunction

command -nargs=* CppSwitchHdrSrc call <SID>SwitchFile(<f-args>)

