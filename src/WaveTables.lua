-- unit tables {'UnitID', OrderType};
--------------------------------------------------------------------------

-- order types

-- 1 = move
-- 2 = attack move
-- 3 = patrol paths

-- wave table entries are in the following format

-- {"Description", OrderType, 'UnitID'},

-- entry 1 is a description text not used by code
-- entry 2 is the order given to this unit
-- entry 3 is the blueprint id and can be added multiple times as needed
-- when a unit table is randomly selected for spawn ONE unit from within will be chosen at random
-- for example if the "T1 Tank" line is selected ONE of the four tanks will be selected for spawning

local tables = {
    2; -- current wave id. Needs to be 2. Gets updated by the code in Survival_UpdateWaves. Really...
    { -- Wave Set 1

        0.0; -- spawn time
        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

    },
    { -- Wave Set 2

        0.75; -- spawn time

        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},
    },
    { -- Wave Set 3

        1.5; -- spawn time

        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
    },
    { -- Wave Set 4

        3.0; -- spawn time

        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
    },
    { -- Wave Set 5

        4.0; -- spawn time

        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
    },
    { -- Wave Set 6

        5.0; -- spawn time

        {"T1 Scout", 3, 'UAL0101', 'URL0101', 'UEL0101', 'XSL0101'},
        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
    },
    { -- Wave Set 7

        6.0; -- spawn time

        {"T1 Bot", 1, 'UAL0106', 'URL0106', 'UEL0106'},

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},

        {"T2 Bomb", 2, 'XRL0302'},
    },
    { -- Wave Set 8

        7.0; -- spawn time

        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 4, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'},
        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
    },
    { -- Wave Set 9

        8.0; -- spawn time

        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 
        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 

        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},

        {"T2 RocketBot", 2, 'DRL0204'},
    },
    { -- Wave Set 10

        9.0; -- spawn time

        {"T1 Tank", 1, 'UAL0201', 'URL0107', 'UEL0201', 'XSL0201'}, 
        {"T1 Arty", 2, 'UAL0103', 'URL0103', 'UEL0103', 'XSL0103'},

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},
    },
    { -- Wave Set 11

        10.0; -- spawn time

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 

        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},
    },
    { -- Wave Set 12

        11.0; -- spawn time

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 4, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'},
        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 
        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 

        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},
    },
    { -- Wave Set 13

        12.0; -- spawn time

        {"T2 Bomb", 2, 'XRL0302'},

        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 
        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 

        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 1, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'}, 

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
    },
    { -- Wave Set 14

        13.0; -- spawn time

        {"T2 Tank", 1, 'XAL0203', 'URL0202', 'UEL0202', 'DEL0204', 'XSL0203'}, 

        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 1, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'}, 

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
    },
    { -- Wave Set 15

        14.0; -- spawn time

        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 4, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'},
        {"T2 HeavyTank", 1, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'}, 

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
    },
    { -- Wave Set 16

        15.0; -- spawn time

        {"Rangeboooooots!", 4, 'DEL0204'},
    },
    { -- Wave Set 17

        16.0; -- spawn time

        {"T2 HeavyTank", 1, 'UAL0202', 'URL0203', 'UEL0203', 'XSL0202'}, 

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
    },
    { -- Wave Set 18

        17.0; -- spawn time

        {"T2 RocketBot", 2, 'DRL0204'},
        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 
    },
    { -- Wave Set 19

        18.0; -- spawn time

        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
    },
    { -- Wave Set 20

        19.0; -- spawn time

        {"T2 MML", 2, 'UAL0111', 'URL0111', 'UEL0111', 'XSL0111'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 
    },
    { -- Wave Set 21

        20.0; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 MML", 2, 'XEL0306'},
    },
    { -- Wave Set 22

        22.5; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},
    },
    { -- Wave Set 23

        25.0; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"Monkeylord", 2, 'URL0402'},
    },
    { -- Wave Set 24

        27.5; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"Monkeylord", 2, 'URL0402'},

        {"Ythotha", 1, "XSL0401"},
    },
    { -- Wave Set 25

        30.0; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"Monkeylord", 1, 'URL0402'}, 
        {"Monkeylord", 2, 'URL0402'},
        {"GC", 2, "UAL0401"},

        {"Ythotha", 1, "XSL0401"},

        {"Megalith", 2, "XRL0403"},
    },
    { -- Wave Set 26

        32.5; -- spawn time

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"T2 Shield", 3, 'UAL0307', 'UEL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"T3 Bot1", 4, 'URL0303', 'UEL0303'},
        {"T3 Bot1", 1, 'URL0303', 'UEL0303'}, 

        {"T3 Bot2", 4, 'UAL0303', 'XSL0303'},
        {"T3 Bot2", 1, 'UAL0303', 'XSL0303'}, 

        {"T3 Bot3", 4, 'XRL0305', 'XEL0305'},
        {"T3 Bot3", 1, 'XRL0305', 'XEL0305'}, 

        {"T3 Sniper", 2, 'XAL0305', 'XSL0305'},

        {"T3 MML", 2, 'XEL0306'},

        {"T3 Arty", 2, 'UAL0304', 'URL0304', 'UEL0304', 'XSL0304'},

        {"Megalith", 2, "XRL0403"},

        {"Fatboy", 3, "UEL0401"},
    },
    { -- Wave Set 27

        35.0; -- spawn time

        {"T3 Shield", 3, 'XSL0307'},
        {"T3 Shield", 3, 'XSL0307'},
        {"T3 Shield", 3, 'XSL0307'},

        {"Monkeylord", 1, 'URL0402'},
        {"Monkeylord", 2, 'URL0402'},
        {"GC", 2, "UAL0401"},

        {"Ythotha", 1, "XSL0401"},
        {"Megalith", 2, "XRL0403"},
        {"Fatboy", 3, "UEL0401"},

        {"", 404, ""},
        {"", 404, ""},
        {"", 404, ""},

        {"", 404, ""},
        {"", 404, ""},
        {"", 404, ""},
    },
}

getWaveTables = function()
    return tables
end