# testing out moving the mouse with powershell

[void] [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
[void] [Reflection.Assembly]::LoadWithPartialName("System.Drawing");

$Screens = [System.Windows.Forms.Screen]::AllScreens;
$Width  = $Screens[0].Bounds.Width;
$Height  = $Screens[0].Bounds.Height;

function moveMouseFromTo {
    param( [int]$x1, [int]$y1, [int]$x2, [int]$y2, [int]$millisBetweenMoves = 10);
    
    # get slope of line from (x1, y1) to (x2, y2)
    $m = ($y1 - $y2)/($x1 - $x2);
    
    if ($x1 -gt $x2) {
        $m = -$m;
    }

    # get y-intercept of line
    $b = $y1 - ($m * $x1);

    $currentX = $x1;
    $currentY = $y1;

    # goes until is past desired x pos
    for($i = $x1; [math]::abs( $currentX-$x2 ) -gt 5; $i+=10){
        # get system mouse object and change position
        [System.Windows.Forms.Cursor]::Position = New-Object System.drawing.Point($currentX, $currentY);

        # update x, y trackers by factor of 10
        if ($m -gt 0) {
        $currentX += 10;
        } else {
            $currentX -= 10;
        }
        $currentY += 10 * $m;

        # make a smooth animation by waiting 10 milliseconds after each iteration
        Start-Sleep -m $millisBetweenMoves;
    }
}

function generatePointsFromNtoM {
    param( [int]$x1, [int]$y1, [int]$x2, [int]$y2);
}

# call function
$i = 0;
while ($i -lt 10) {
    moveMouseFromTo 0 0 $Width $Height;
    moveMouseFromTo $Width $Height 0 0;

    $i++;
}

# for debug:
Start-Sleep -s 50;