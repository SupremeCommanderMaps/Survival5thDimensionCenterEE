version = 3
ScenarioInfo = {
    name = 'Survival 5th Dimension Center EE',
    map_version=4,
    description = 'Based on Original Survival 5th dimension :*GameSettings* Put 4 AI ACUs in slots 5-8.  Player ACUs go in slots 1-4.  The 4 AI commanders are in prison, and it is your job to defend the position until the teleporter can be finished.  Modified by Phelom, Spoon, and Duck_42.  Thanks to the map author.',
    type = 'skirmish',
    starts = true,
    preview = '',
    size = {512, 512},
    map = '/maps/survival_5th_dimension_center_ee.v0004/survival_5th_dimension_center_ee.scmap',
    save = '/maps/survival_5th_dimension_center_ee.v0004/survival_5th_dimension_center_ee_save.lua',
    script = '/maps/survival_5th_dimension_center_ee.v0004/survival_5th_dimension_center_ee_script.lua',
    norushradius = 50.000000,
    norushoffsetX_ARMY_1 = 0.000000,
    norushoffsetY_ARMY_1 = 0.000000,
    norushoffsetX_ARMY_2 = 0.000000,
    norushoffsetY_ARMY_2 = 0.000000,
    norushoffsetX_ARMY_3 = 0.000000,
    norushoffsetY_ARMY_3 = 0.000000,
    norushoffsetX_ARMY_4 = 0.000000,
    norushoffsetY_ARMY_4 = 0.000000,
    norushoffsetX_ARMY_5 = 0.000000,
    norushoffsetY_ARMY_5 = 0.000000,
    norushoffsetX_ARMY_6 = 0.000000,
    norushoffsetY_ARMY_6 = 0.000000,
    norushoffsetX_ARMY_7 = 0.000000,
    norushoffsetY_ARMY_7 = 0.000000,
    norushoffsetX_ARMY_8 = 0.000000,
    norushoffsetY_ARMY_8 = 0.000000,
    Configurations = {
        ['standard'] = {
            teams = {
                { name = 'FFA', armies = {'ARMY_1','ARMY_2','ARMY_3','ARMY_4','ARMY_5','ARMY_6','ARMY_7','ARMY_8',} },
            },
            customprops = {
                ['ExtraArmies'] = STRING( 'ARMY_SURVIVAL_ALLY ARMY_SURVIVAL_ENEMY' ),
            },
        },
    }}
