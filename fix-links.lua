function Link(link)
    link.target = link.target:gsub('(.+)%.md%#(.+)', '%1.html#%2')
    link.target = link.target:gsub('(.+).md$', '%1.html')
    return link
end

function Header(h)
    if h.level <= 4 then
        local link = pandoc.Link(
            h.content:clone(),
            '#' .. h.attr.identifier,
            nil,
            { class = 'header-link' }
        )
        return pandoc.Header(h.level, link, h.attr)
    end
    return h
end
