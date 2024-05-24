return function(spaces)
    if spaces == nil or spaces < 1 then
        spaces = 1
    end

    return {
        provider = string.rep(" ", spaces),
    }
end

