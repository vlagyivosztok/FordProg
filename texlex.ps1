﻿param([string]$cmd='', [string]$file='', $split = '#') 

#region

#endregion

function main {

$file = "D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt"

$cmd = "#u#b#g\splm#e#i-----#r4#n#sadatok2#x#iconcurr#r4#n#stomb3#"
$cmd += '#o#b#g-----\n\s{2}#r7#e#g\n\s{2}#r3#n#stomb1#t0#'
$cmd += '#n#f#'

#write-host  $cmd
$cmd = $cmd -replace '##','#'

write-host 'input data: ' $cmd $file 


if ( $file.length -gt 0 ){
    if(test-path $file){
            write-host 'file valid'
    }else{
        write-host 'file invalid'
        exit
    }
}else{
    write-host 'file invalid'
    exit
}

#region globals
$global:cmds =@{   b = ''; # begin
            e = ''; #end
            i = 'string'; #c insens find
            c = 'string'; #c sens find
            g = 'string'; #find regex
            r = 'int32'; #rel pos
            o = ''; #start multiple 
            t = 'int32'; #count multiple
            u = ''; #start until
            x = ''; # until condition
            s = 'string'; # save in array, named string
            n = ''; #insert LF
            p = ''; #output stream
            f = ''} # end symbol

$global:seq = $none
$global:cmdset = $none
#$global:pos
#$global:filetext

$global:result = ''
$global:result_data = @{}

#endregion globals                        

#region states
$global:states = @(@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}) #23

$global:states[0] = @{'b' = 1;'o' = 4;'u' = 4}
$global:states[1] = @{'i' = 2;'c' = 2;'g' = 2;'r' = 3} 
$global:states[2] = @{'b' = 1;'r' = 3;'e' = 8} 
$global:states[3] = @{'b' = 1;'e' = 8} 
$global:states[4] = @{'b' = 5} 
$global:states[5] = @{'i' = 6;'c' = 6;'g' = 6;'r' = 7} 
$global:states[6] = @{'r' = 7;'e' = 13}
$global:states[7] = @{'e' = 13}
$global:states[8] = @{'i' = 9;'c' = 9;'g' = 9;'r' = 10} 
$global:states[9] = @{'b' = 1;'o' = 4;'u' = 4;'r' = 10;'n' = 11;'s' = 12; 'f' = 23} 
$global:states[10] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 11;'s' = 12; 'f' = 23}
$global:states[11] = @{'b' = 1;'o' = 4;'u' = 4;'s' = 12; 'f' = 23}
$global:states[12] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 11;'f' = 23}
$global:states[13] = @{'i' = 14;'c' = 14;'g' = 14;'r' = 15} 
$global:states[14] = @{'b' = 1;'r' = 15;'n' = 16;'s' = 17;'x' = 18;'t' = 20} 
$global:states[15] = @{'b' = 1;'n' = 16;'s' = 17;'x' = 18;'t' = 20}  
$global:states[16] = @{'b' = 1;'s' = 17;'x' = 18;'t' = 20}
$global:states[17] = @{'b' = 1;'n' = 16;'x' = 18;'t' = 20}
$global:states[18] = @{'i' = 19;'c' = 19;'g' = 19;'r' = 20} 
$global:states[19] = @{'b' = 1;'o' = 4;'u' = 4;'r' = 20;'n' = 21;'s' = 22;'f' = 23}
$global:states[20] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 21;'s' = 22;'f' = 23}
$global:states[21] = @{'b' = 1;'o' = 4;'u' = 4;'s' = 22;'f' = 23}
$global:states[22] = @{'b' = 1;'o' = 4;'u' = 4;'n' = 21;'f' = 23}


#$global:states[17] = @{'f' = 18}
#endregion states                     



write-host "`r`n splitter literal : " $split
cmd_read $cmd

if( $null -ne $global:cmdset) {
write-host "`r`n command syntactically valid `r`n" #($global:cmdset | out-string)
}else{
    write-host "`r`n something went wrong `r`n"
    exit
}
#write-host ($global:cmdset | out-string)

cmdset_read 
$global:filetext = [IO.File]::ReadAllText($file)

execute 

#$global:filetext
#pause

} #main

function execute{
#$global:seq

$loop_result =''
$iloop_result =''
$counter = 0
$global:index = 0
#$pos1 = 0
$cond = $false

$test = $true

if ($test){
    foreach ($step in $global:seq){
        write-host $global:seq.indexof($step)'. step '($step | out-string)
        foreach ($iloop in $step.loop){
            write-host $step.loop.indexof($iloop)'. iloop '($iloop | out-string)
        }   #$array.indexof($element)
    }
#exit
}

foreach ($step in $global:seq){ # nagykorok
    # lehet o-t, darabszamszor
    #lehet u-x feltételig
    #van benne egy loop()   ebbe megy az iloop belso ciklus
    #lehet meg n, s
    # a vege f ??

    if($step.ContainsKey('o') ){  #van o tobbszorozes, biztos, ami biztos nagyobb 0
        if([int]$step['t'] -lt 1 ){
            write-host 't is less then 1...'
            exit
        }elseif(-not $step['u']){

        }
    }

    # a vari ciklus előtt minden érték ismert.
    # o, t nagyobb 0 szémlálásnál t létét kérdezzük le feltételként
    # u-x nél i-c-g r alapján 3 if-fel előre megkeressük a feltétel poziciojat
    #
  

# $index az aktualis abszolut pozicio a szovegben
#write-host ((($counter -lt $t) -or ($null -eq $t)) -and (-not $cond))
    while((($counter -lt $t) -or ($null -eq $t)) -and (-not $cond)){
        #$counter t-ig számlál, ha van t
        #u-x nél 
        $cond_pos = step_find $step

        #a kovetkezo loop elemmel
        #eleje kereses
        #osszehasonlitas $con_pos

        #vege kereses
        #osszehasonlitas $con_pos
        $iloop_result = ''
        foreach ($iloop in $step.loop){
            #loop() elemei bicg, br, eicg, er, n,s       
            #az iloop hivja 2x a kereseseket es a kozte levot 
            # a vegen n soremeles hozzafuz
            # a vegen s, adatszerkezethez

            # mindkettot egy tombben kell visszakapni
            # egyszerre elkeszulnek
            $range = loop_find $iloop

            if((($range.Get_Item('b') -lt $cond_pos) -and ($range.Get_Item('e')  -lt $cond_pos)) -or (($counter -lt $t) -or ($null -eq $t))){
                #az aktualis range belul van $cond_pos on

                $iloop_result += $global:filetext.substring($range.Get_Item('b'), $range.Get_Item('e')-$range.Get_Item('b')+1)

                $loop_result += $iloop_result
                if ($iloop['n']){
                    $iloop_result += "`r`n"
                }
                if ($iloop['s']){
                    if(-not [bool]$global:result_data[[string]($iloop['s'])] ){
                    $global:result_data[[string]($iloop['s'])] = @()
                    }
                    $global:result_data[[string]($iloop['s'])] += $iloop_result
                }
            }
        }   #foreach ($iloop in $step.loop)     idaig

        if($step.ContainsKey('o')){ $counter += 1 }
    }
    $loop_result += $iloop_result
    if ($step['n']){
        $loop_result += "`r`n"
    }
    if ($step['s']){
        if(-not [bool]$global:result_data[[string]($step['s'])] ){
        $global:result_data[[string]($step['s'])] = @()
        }
        $global:result_data[[string]($step['s'])] += $loop_result
    }
    $global:result += $loop_result
}   #foreach ($step in $cmd_seq)
}   #function execute



<# if($step.ContainsKey('g') ){
    write-host $findfname+' g '+$index+' '+$step['g']
    $pos1 = Invoke-Expression $findfname+' g '+$index+' '+$step['g']  
} #>

function step_find{
    param(
        $step
    )
    $pos = -1
    foreach($key in $step.keys){
        #write-host $key
        if($key.indexof('i') -gt -1 -or $key.indexof('c') -gt -1 -or $key.indexof('g') -gt -1 ){
            $expr1 = (("find_"+$key)+' '+($global:index)+' "'+($step.Get_Item($key))+'" '+($step.Get_Item('r'))).Replace("`r`n","")
            #write-host $expr1 
            #pos-nak dict-et, mert a sorrend nem biztos. A dict a 0. betu nevebol
            $pos = Invoke-Expression $expr1 
        }
    }
    $pos
}

function loop_find{
    param(
        $step
    )
    $pos = @{}
    foreach($key in $step.keys){
        #write-host $key
        <# $key = $key.Replace("e","")
        $key = $key.Replace("b","") #>
        $rel = $key.substring(0,1)+'r'
        if($key.indexof('i') -gt -1 -or $key.indexof('c') -gt -1 -or $key.indexof('g') -gt -1 ){
            $expr1 = (("find_"+($key.Replace("e","")).Replace("b",""))+' '+($global:index)+' "'+($step.Get_Item($key))+'" '+($step.Get_Item($rel))).Replace("`r`n","")
            write-host $expr1 
            $pos[$key.substring(0,1)] = Invoke-Expression $expr1 
        }
    }
    $pos
}


function cmdset_read{

$global:seq = @()  # lista a loop elemekkel
$pair_counter = @{'o' = 0; 'u' = 0 ; 't' = 0 ; 'x' = 0 }
$state = 0

foreach ($cmd in $global:cmdset){

    if($cmd.keys -eq 'u' -or $cmd.keys -eq 'o'){
        $global:seq += @{}     # tobbszorozos mindig uj dict
        $seq_counter = $global:seq.length-1
        $global:seq[$seq_counter][[string]$cmd.keys] = '' # u vagy o
        $pair_counter[[string]$cmd.keys] += 1
        $tx = $false        
    }

    if($cmd.keys -eq 'b' -and ($state -lt 4 -or $state -gt 17)){
        $global:seq += @{}
        $seq_counter = $global:seq.length-1
    }

    if($cmd.keys -eq 'b'){
        if(-not [bool]$global:seq[$seq_counter]['loop'] ){
            $global:seq[$seq_counter]['loop'] = @()
        }
        ($global:seq[$seq_counter]['loop']) += @{}
        $loop_counter = ($global:seq[$seq_counter]['loop']).Count -1
    }
 
    if(($state -lt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
       ((($global:seq[$seq_counter]['loop'])[$loop_counter]))['b'+[string]$cmd.keys] = ($cmd.values | out-string)
    }

    if(($state -lt 7) -and $cmd.keys -eq 'r' ){
        ((($global:seq[$seq_counter]['loop'])[$loop_counter]))['b'+[string]$cmd.keys] = ($cmd.values | out-string)   
    }
    if(($state -gt 7) -and ($cmd.keys -eq 'i' -or $cmd.keys -eq 'c' -or $cmd.keys -eq 'g')){
        if($tx){
            $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
        }else{((($global:seq[$seq_counter]['loop'])[$loop_counter]))['e'+[string]$cmd.keys] = ($cmd.values | out-string)
        }
    }

    if(($state -gt 7) -and $cmd.keys -eq 'r' ){
        if($tx){
            $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
        }else{((($global:seq[$seq_counter]['loop'])[$loop_counter]))['e'+[string]$cmd.keys] = ($cmd.values | out-string)
        }
    }

    if(($state -lt 18) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's')){  # sima belso vege
        ((($global:seq[$seq_counter]['loop'])[$loop_counter]))[[string]$cmd.keys] = ($cmd.values | out-string)
    }

    if(($state -gt 18) -and ($cmd.keys -eq 'n' -or $cmd.keys -eq 's')){  # sima belso vege
        $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
    }

    if($cmd.keys -eq 't' -or $cmd.keys -eq 'x'){  # sima belso vege
        $global:seq[$seq_counter][[string]$cmd.keys] = ($cmd.values | out-string)
        $pair_counter[[string]$cmd.keys] += 1
        $tx = $true 
    }

    if($cmd.keys -eq 'f'){  # sima belso vege
        $global:seq[$seq_counter][[string]$cmd.keys] = ''
    }
########

    #a végén állítjuk elő a következő lépést
    #Write-Host 'old ' $state 'cmd: ' $cmd.keys
    $state = ($global:states[$state])[[string]$cmd.keys]
    if (-not $state ){
        write-host 'state error'
    }

#if($state -eq 17 -and (-not ))
#Write-Host 'new: ' $state
}   # foreach ($cmd in $global:cmdset)


#write-host ($global:seq | out-string)

if($state -eq 23){
    if(($pair_counter['o'] -eq $pair_counter['t']) -and ($pair_counter['u'] -eq $pair_counter['x'])){
        Write-Host 'Command sequence processed succsesfully'
    }else{
        Write-Host 'Command sequence error, o-t or u-x pairs not match'
        exit
    }
}else{
    Write-Host 'Command sequence error, no acc.'
    exit
}
}   # function cmdset_read

function find_c{
    param(
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
    )
    $pos = -1
    $pos =  ($where.substring($start)).IndexOf($what)
    if($pos -gt -1){
        $pos += $rel
    }
    $pos
}

function find_i{
    param(
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
    )
    $pos = -1
    $pos =  (($where.ToLower()).substring($start)).IndexOf($what.ToLower())
    if($pos -gt -1){
        $pos += $rel
    }
    $pos
}

function find_g{
    param(
        [int]$start,
        [string]$what,
        [int]$rel = 0,
        [string]$where = $global:filetext
    )
    $pos = -1
    $search =  [regex]::match($where.substring($start),$what)
    $pos = $search.index
    if($search.success){
        $pos += $rel
    }
    $pos
}

function cmd_read{
    param(
        $cmd
    )
    $index = 0
    $pos1 = 0
    $global:cmdset = @()
    #$notype = $true
    while (($index -lt $cmd.length-2) -and ($pos1 -ne -1)) { #a szoveg hosszan belul es talalt kovetkezot
        $pos1 = find_c $index $split 1 $cmd      # a kovetkezo # utani abszolut index
        if ($pos1 -ne -1){              # ha van kovetkezo #
            $index += $pos1 # a parancs betujenel allunk    Abszolut index-szel a talalat elejere allunk
            #write-host $cmd $index
            #write-host 'index+pos1: '$index
            #write-host $cmd.substring($index,1)
            if($global:cmds.ContainsKey($cmd.substring($index,1))){    #lekerdezzuk, hogy van-e ilyen parancs
                #write-host 'parancs' 
                $pos2 =  (find_c $index $split -1 $cmd ) # elmegyunk a kovetkezo # ig
                #write-host $cmd $index $pos2 
                if($global:cmds[$cmd.substring($index,1)] -ne ''){ #van argumentum tipus 
                    if ($pos2 -gt 0 ){  #ha 1, akkor nincs argumentum a parancshoz
                        Set-Variable 'arg' -Value ($cmd.substring($index+1,$pos2) -as ($global:cmds[$cmd.substring($index,1)] -as [type]))
                        #write-host $arg ($cmd.substring($index+1,$pos2))
                        if($arg -eq $cmd.substring($index+1,$pos2)){
                    
                            $global:cmdset +=  @{$cmd.substring($index,1) = $arg}
                        }else{
                            write-host 'argument type mismatch at pos :' ($index+1) ':' $cmd.substring($index+1,$pos2)
                            exit
                        }
                    }else{
                        #kotelezo argumentum hianyzik
                        write-host 'ERROR command argument missing at pos. '($index+1)
                        write-host 'succesfully processed commands and arguments:'
                        write-host ($global:cmdset | out-string)
                        write-host 'ERROR quit'
                        exit
                    }
                }elseif($pos2 -eq 0){ #nincs argumentum, csak parancs
                $global:cmdset +=  @{$cmd.substring($index,1) = ''} #csak beirja
                }else{
                    $global:cmdset +=  @{$cmd.substring($index,1) = ''}  #beirja es jelez
                    write-host 'not processed input at pos :' ($index+1) ':'  $cmd.substring($index+1,$pos2)

                }
            }else{ #nincs ilyen parancs, mehetunk tovabb
                Write-Host 'unknown command: '$cmd.substring($index,1) 
            }

                #write-host 'index'$index
                $index += $pos2
                #write-host 'index+pos2: '$index 
        }
    }
    #$global:cmdset
}

main 
