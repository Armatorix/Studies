\insert 'NewPortObject.oz'
\insert 'NewPortObject2.oz'
\insert 'Lift.oz'
\insert 'Timer.oz'
\insert 'Floor.oz'
\insert 'Controller.oz'
\insert 'Building.oz'
declare F L in
{Building 20 2 F L}
{Send F.20 call}
{Send F.4 call}
{Send F.10 call}
{Send L.1 call(4)}