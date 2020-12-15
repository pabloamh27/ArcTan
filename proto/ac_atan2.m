% Instituto Tecnológico de Costa Rica
% Centro Académico Alajuela
% Esuela de Ingeniería en Computación
% IC-3101 Arquitectura de Computadores
% II Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% atan2 implementation file
% File:   ac_atan2.m
% Brief:  Implementation of atan2 function
% Input:  x coordinate, y coordinate of complex number
% Output: theta: angle of vector
%
% Grupo 01
% Pablo Muñoz Hidalgo
% Royner Miranda Segura
% Fernando Vega Valerio
%
function [theta, octant] = ac_atan2(real_part, imag_part)
  octant = 0;
  theta = 0;
  
	x = real_part;
  y = imag_part;
  absx = 0;
  absy = 0;
  
  if (x < 0)
    absx = x*-1;
  endif

  if (y < 0)
    absy = y*-1;
  endif
  
  y2 = y*y;
  x2 = x*x;
  
  Q15_PI = 102944;
  Q15_PI_MEDIOS = 51472;
  Q15_PI_CUARTOS = 25736;
  Q15_PI_TRESCUARTOS = 77208;
  
  numerador = x * y;
  
  denominador = (x2)+bitshift(y2,-2)+bitshift(y2,-5);
  denominador_invertido = (y2)+bitshift(x2,-2)+bitshift(x2,-5);
  
  denominador = bitshift(denominador, -15);
  denominador_invertido = bitshift(denominador_invertido, -15);
  
  if (x > 0 && y == 0)
    theta = 0;
    return;
  
  elseif (x == y && x > 0)
    theta = Q15_PI_CUARTOS;
    return;
    
  elseif (x == y && x < 0)
    theta = -Q15_PI_TRESCUARTOS;
    return;
    
  elseif (x == y*-1 && x < 0)
    theta = Q15_PI_TRESCUARTOS;
    return;
    
  elseif (x*-1 == y && y < 0)
    theta = -Q15_PI_CUARTOS;
    return;
    
  elseif (x < 0 && y == 0)
    theta = Q15_PI;
    return;
    
  elseif (x == 0 && y > 0)
    theta = Q15_PI_MEDIOS;
    return;
    
  elseif (x == 0 && y < 0)
    theta = -Q15_PI_MEDIOS;
    return;
    
  elseif (x == 0 && y == 0)
    theta = "Undefined";
    return;
    
  endif

  %Sacar el octante
  if (x>0 && y>0)
    if (x > y)
      octant = 1;
    else
      octant = 2;
    endif
  elseif (x<0 && y>0)
    if (absx > y)
      octant = 4;
    else
      octant = 3;
    endif
  elseif (x<0 && y<0)
    if (absx > absy)
      octant = 5;
    else
      octant = 6;
    endif
  else
    if (x > absy)
      octant = 8;
    else
      octant = 7;
    endif
  endif

  %Sacar el valor de theta
  if (octant == 1 || octant == 8)
    theta = numerador/denominador;
  
  elseif (octant == 2 || octant == 3)
    theta = Q15_PI_MEDIOS - (numerador/denominador_invertido);
  
  elseif (octant == 4)
    theta = (numerador/denominador) + Q15_PI;
  
  elseif (octant == 5)
    theta = (numerador/denominador) - Q15_PI;
  
  else
    theta = -Q15_PI_MEDIOS - (numerador/denominador_invertido);
  
  endif

  theta = round(theta);
  return;
endfunction