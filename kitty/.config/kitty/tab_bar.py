from kitty.fast_data_types import (
    Color,
    Screen,
    get_options,
)
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
)
from kitty.utils import color_as_int

# Globals
SEPARATOR_SYMBOL_LEFT = "";
SEPARATOR_SYMBOL_RIGHT = "";

OPTIONS = get_options()

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    #print(draw_data)
    #print(screen)
    #print(tab)
    #print(before)
    #print(max_title_length)
    #print(index)
    #print(is_last)
    #print(extra_data)

    ## Define a function to draw an icon on the far left

    ## Define a function to draw all tabs

    ## Define a function to draw a status bar/tab on the far right

    draw_tab_with_separator(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )

    return screen.cursor.x


