local M = {}

local get_map = function(map, lhs)
    for _, value in ipairs(map) do
        if value.lhs == lhs then
            return value
        end
    end
end

-- convention -> dont fuck with _variables
M._stack = {}

M.push = function(name, mode,  mappings)
    local maps = vim.api.nvim_get_keymap(mode)
    local existing_maps = {}
    for lhs, rhs in pairs(mappings) do
        local existing = get_map(maps,lhs)
        if existing then
            -- table is global - has table operations: .insert most common
            table.insert(existing_maps, existing)
        end
    end

    M._stack[name] = existing_maps

    for lhs, rhs in pairs(mappings) do
        vim.keymap.set(mode, lhs,rhs)
    end
end
--
-- M.pop= function(name)
-- end

-- M.push("debug", "n", {
--     [" x"] = "echo 'hihi'",
--     [" pp"] = "echo 'hihi'"
-- })

return M
