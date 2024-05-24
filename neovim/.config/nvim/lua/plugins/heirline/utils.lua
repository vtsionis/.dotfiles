local M = {}

M.extend = function(base, extension)
    local extended = {}

    for key, value in pairs(base) do
        extended[key] = value
    end
    for key, value in pairs(extension or {}) do
        if extended[key] == nil then
            extended[key] = value
        end
    end

    return extended
end

return M

