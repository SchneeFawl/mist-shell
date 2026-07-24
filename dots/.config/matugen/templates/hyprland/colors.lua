hl.config({
    general = {
        col = {
            active_border = {
                colors = {
                    "{{colors.primary.default.hex}}",
                    "{{colors.secondary.default.hex}}",
                },
                angle = 60,
            },
            inactive_border = {
                colors = {
                    "{{colors.tertiary.default.hex}}",
                    "{{colors.outline.default.hex}}",
                },
            },
        },
    },

    misc = {
        background_color = "{{colors.surface_variant.default.hex}}",
    },
})
