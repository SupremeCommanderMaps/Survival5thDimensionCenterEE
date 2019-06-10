version = 3
ScenarioInfo = {
    name = 'Survival 5th Dimension Center EE',
    map_version=6,
    description = 'Survive for 35 minutes and defend the Defence Object at the center of the map. Can be played with less than 4 players, as the map adjusts to the player count. Version history and developer info can be found in the README.md file.',
    type = 'skirmish',
    starts = true,
    preview = '',
    size = {512, 512},
    map = '/maps/survival_5th_dimension_center_ee.v0006/survival_5th_dimension_center_ee.scmap',
    save = '/maps/survival_5th_dimension_center_ee.v0006/survival_5th_dimension_center_ee_save.lua',
    script = '/maps/survival_5th_dimension_center_ee.v0006/survival_5th_dimension_center_ee_script.lua',
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
