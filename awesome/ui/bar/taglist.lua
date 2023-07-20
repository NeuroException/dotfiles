local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local rubato        = require("utils.lib.rubato")
local bling         = require("utils.lib.bling")
local colors        = require("config.colors")


beautiful.tag_preview_widget_border_radius          = 10
beautiful.tag_preview_client_border_radius          = 10
beautiful.tag_preview_client_opacity                = 1.0
beautiful.tag_preview_client_bg                     = colors.bg
beautiful.tag_preview_client_border_color           = colors.base
beautiful.tag_preview_client_border_width           = 3
beautiful.tag_preview_widget_bg                     = colors.bg
beautiful.tag_preview_widget_border_color           = colors.base
beautiful.tag_preview_widget_border_width           = 3
beautiful.tag_preview_widget_margin                 = 10

beautiful.taglist_fg_focus                          = colors.accent
beautiful.taglist_fg_urgent                         = colors.bg
beautiful.taglist_fg_occupied                       = colors.bg
beautiful.taglist_fg_empty                          = colors.bg
beautiful.taglist_fg_volatile                       = colors.bg
beautiful.taglist_bg_focus                          = colors.accent
beautiful.taglist_bg_urgent                         = colors.accent
beautiful.taglist_bg_occupied                       = colors.mantle
beautiful.taglist_bg_empty                          = colors.mantle
beautiful.taglist_bg_volatile                       = colors.mantle

local taglist = {}

function taglist.create(s)

    bling.widget.tag_preview.enable {
        screen = s,
        show_client_content = false,
        x = 10,
        y = 10,
        scale = 0.10,
        honor_padding = false,
        honor_workarea = false,
        placement_fn = function(c)
            awful.placement.top_left(c, {
                margins = {
                    top = 45,
                    left = 30
                }
            })
        end
    }

    local taglist_widget = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_rect,
        },
        layout = {
            spacing = 5,
            layout = wibox.layout.fixed.horizontal,
        },
        buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                {
                    markup = '',
                    widget = wibox.widget.textbox,
                },
                id = 'background_role',
                forced_height = 7,
                forced_width = 7,
                widget = wibox.container.background,
            },
            widget = wibox.container.margin,
            top = 9,
            bottom = 9,
            left = 5,
            right = 5,
            create_callback = function (self, tag)
                self.animate = rubato.timed {
                    intro = 0.1,
                    outro = 0.7,
                    duration = 1,
                    subscribed = function (w)
                        self:get_children_by_id('background_role')[1].forced_width = w
                    end
                }
                self.update = function ()
                    if tag.selected then
                        self.animate.target = 15
                    elseif #tag:clients() > 0 then
                        self.animate.target = 15
                    else
                        self.animate.target = 7
                    end
                end
                self.update()
                self:connect_signal('mouse::enter', function()
                    if #tag:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", tag)
                        awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    end
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function (self)
                self.update()
            end,
        }
    }

    return taglist_widget
end

return taglist

