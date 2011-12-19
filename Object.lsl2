/*
 *  Build Box
 *  Primitive recorder/installer for LSL and Open Simulator platforms
 *
 *  Copyright 2011-2012, Marc S. Brooks (http://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to the contents of each object or linked set root
 */

integer channel = 300;    // build box channel
integer verbose = FALSE;
vector  master;

/*
 * Set object properties vector position and rotation axis
 */
move_object(key id)
{
    // parse data stored in the object description
    list llist = llCSV2List( llGetObjectDesc() );

    if (llist == "" && id != llGetKey() )
    {
        return;
    }

    // split elements
    vector   offset = llList2Vector(llist, 0);
    rotation rot    = llList2Rot(   llist, 1);
    vector   target = master + offset;
    vector   last;

    do {
        last = llGetPos();

        // set object properties
        llSetPos(target);
        llSetRot(rot);
    }
    while ( (llVecDist(llGetPos(), target) > 0.001) && (llGetPos() != last) );

    if (verbose)
    {
        llSay(0, "Pos: "    + (string)master);
        llSay(0, "Rot: "    + (string)rot   );
        llSay(0, "Target: " + (string)target);
        llSay(0, "Offset: " + (string)offset);
    }
}

/*
 * Store object properties vector position and rotation axis
 */
save_location()
{
    vector   pos    = llGetPos();
    vector   size   = llGetScale();
    rotation rot    = llGetRot();
    vector   offset = <(float)(pos.x - master.x), (float)(pos.y - master.y), (float)(pos.z - master.z)>;

    // write to description field
    llSetObjectDesc( (string)offset + "," + (string)rot);

    if (verbose)
    {
        llSay(0, "Master: " + (string)master);
        llSay(0, "Pos: "    + (string)pos   );
        llSay(0, "Rot: "    + (string)rot   );
        llSay(0, "Offset: " + (string)offset);
    }
}

/*
 * Listen to channel for transmission from 'build box' object
 */
default
{
    on_rez(integer param)
    {
        llResetScript();
    }

    state_entry()
    {
        llListen(channel, "", NULL_KEY, "");
    }

    listen(integer channel, string name, key id, string msg)
    {
        list   params = llParseString2List(msg,["|"], []);
        string action = llList2String(params, 0);
        vector pos    = llList2Vector(params, 1);
        key    uuid   = llList2Key(   params, 2);

        master = pos;

        if (action == "Install")
        {
            move_object(uuid);
        }

        if (action == "Record")
        {
            save_location();
        }
    }
}
