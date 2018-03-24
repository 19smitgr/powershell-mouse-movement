# this is a demonstration of how physics can be helpful in coding

[void] [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
[void] [Reflection.Assembly]::LoadWithPartialName("System.Drawing");

$Screens = [System.Windows.Forms.Screen]::AllScreens;
$Width  = $Screens[0].Bounds.Width;
$Height  = $Screens[0].Bounds.Height;

# this function isn't super modular because it makes several assumptions, 
# but it works in its current state
function mouseBounce {
    $x = 1;
    $y = $Height;
    $xVelocity = 10;
    $initialYVelocity = -35;
    $yVelocity = $initialYVelocity; # keep in mind -35 means down the screen
    $acceleration = 1; # this is deceleration

    while ($true) {
        if ($x -ge $Width -or $x -le 0) {
            $xVelocity *= -1;
        }

        $x += $xVelocity;

        if ($y -eq $Height) {
            $yVelocity = $initialYVelocity;
        }

        $y += $yVelocity;

        $yVelocity += $acceleration;

        [System.Windows.Forms.Cursor]::Position = New-Object System.drawing.Point($x, $y);

        # make a smooth animation by waiting 10 milliseconds after each iteration
        Start-Sleep -m 25;
    }
}

mouseBounce;

Start-Sleep -s 50;