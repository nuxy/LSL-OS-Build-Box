/**
 *  Build Box
 *  Primitive recorder/installer for LSL and Open Simulator platforms
 *
 *  Copyright 2011-2012, Marc S. Brooks (https://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to the contents of the root 'build box' object
 */

integer channel = 300;    // Build box channel
integer lkey;
integer verbose = FALSE;
string  text = "Package Manager";
vector  target;

/**
 * Instantiate each object to the region.
 */
rez_objects()
{
    string  name;
    integer num = llGetInventoryNumber(INVENTORY_OBJECT);
    integer count;

    if (num > 0)
    {
        llOwnerSay("Rezzing Objects");

        // Iterate each object stored in 'build box' contents.
        for (; count < num; count++)
        {
            name = llGetInventoryName(INVENTORY_OBJECT, count);

            if (llGetInventoryPermMask(name, MASK_OWNER) & PERM_COPY)
            {
                llRezObject(name, llGetPos() + <0.0,0.0,1.0>, <0.0,0.0,0.0>, llGetRot(), 0);

                if (verbose)
                {
                    llOwnerSay("Rezzing " + name);
                }
            }
        }
    }
    else
    {
        llOwnerSay("No Objects Found");
    }
}

default
{
    on_rez(integer param)
    {
        llResetScript();
    }

    /**
     * Align 'build box' object to the highest point of the region heightmap.
     */
    state_entry()
    {
        llOwnerSay(text + " Initializing...");
        llSleep(2);
        llSetPrimitiveParams([ PRIM_PHYSICS, TRUE ]);
    }

    land_collision(vector pos)
    {

        // 'Build Box' current vector position.
        target = llGetPos();

        if (verbose)
        {
            llOwnerSay("Setting Target Position " + (string)target);
        }

        llSleep(2);
        llSetPrimitiveParams([ PRIM_PHYSICS, FALSE ]);
    }

    /**
     * Open dialog menu; listen for button events.
     */
    touch_start(integer num)
    {
        if (llDetectedKey(0) == llGetOwner() )
        {
            lkey = llListen(8192, "", llGetOwner(), "");

            llSetTimerEvent(60);
            llDialog(llDetectedKey(0), text, [ "Install","Record" ], 8192);
        }
    }

    timer()
    {
        llListenRemove(lkey);
        llSetTimerEvent(0);
    }

    listen (integer channel, string name, key id, string msg)
    {
        llListenRemove(lkey);

        if (msg == "Install")
        {
            llMessageLinked(LINK_SET, 0, msg, NULL_KEY);
        }

        if (msg == "Record")
        {
            llMessageLinked(LINK_SET, 0, msg, NULL_KEY);
        }
    }

    link_message(integer to, integer from, string msg, key id)
    {
        llOwnerSay(text + " " + msg + "ing...");
        llSleep(2);

        if (msg == "Install")
        {
            rez_objects();
        }

        if (msg == "Record")
        {
            llSay(channel, "Record|" + (string)target);
        }
    }

    /**
     * Transmit message containing the 'build box' vector position and rotation axis data.
     */
    object_rez(key id)
    {
        llSay(channel, "Install|" + (string)target + "|" + (string)id);
    }
}
