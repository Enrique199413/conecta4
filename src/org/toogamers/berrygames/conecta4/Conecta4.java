package org.toogamers.berrygames.conecta4;

import java.util.Scanner;
public class Conecta4{
	public static void main (String []args){
            int w=0;
            int z=0;
            int x=5;
            int n=0;
            int a=0;
            int o=0;
            int h=0;
            int b=0;
            int j=0;
            int i=0;
            int g=1;
            Scanner scan = new Scanner(System.in);
            String arreglo[][] = new String[6][6];
            for(i =0;i<6;i++){
                for(j=0;j<6;j++){
                    arreglo[i][j] = "*";
                    System.out.print(arreglo[i][j]);
                    if(j==5){
                            System.out.print("\n");
                    }
                }
            }
        while(n==0)
        {
            if(g==1){
                System.out.println("Teclee jugador "+g+" del 1 al 6 en donde va a ir su ficha A");
            }
            if(g==2){
                System.out.println("Teclee jugador "+g+" del 1 al 6 en donde va a ir su ficha B");
            }
            a = scan.nextInt();
            a--;
            for(int k =0;k<6;k++){
                if(!"*".equals(arreglo[x][a])){
                    x--;
                }
            }
            for(i =0;i<6;i++){
                for(j=0;j<6;j++){
                    if("A".equals(arreglo[i][j])){
                        w++;
                    }else{
                        w=0;
                    }
                    if("B".equals(arreglo[i][j])){
                        z++;
                    }else{
                        z=0;
                    }
                    if(w==4){
                        if(g==2){
                            n=1;
                            g=1;
                        }
                    }
                    if(z==4){
                        if(g==1){
                            n=2;
                            g=2;
                        }
                    }
                    if("*".equals(arreglo[i][j])&&g==1&&!"B".equals(arreglo[x][a])&&!"A".equals(arreglo[x][a])){
                            arreglo[x][a]="A";
                            g=2;
                            x=5;
                    }
                    if("*".equals(arreglo[i][j])&&g==2&&!"A".equals(arreglo[x][a])&&!"B".equals(arreglo[x][a])){
                            arreglo[x][a]="B";
                            g=1;
                            x=5;
                    }
                    System.out.print(arreglo[i][j]);
                    if(j==5){
                        System.out.print("\n");
                    }
                }
            }
            for(h=5;h>0;h--){
                if("A".equals(arreglo[h][a])){
                    o++;
                    if(o==4){
                        n=1;
                        g=1;
                        break;
                    }
                }else{
                    o=0;
                }
                if("B".equals(arreglo[h][a])){
                    b++;
                    if(b==4){
                        n=2;
                        g=2;
                        break;
                    }
                }
                else{
                    b=0;
                }
            }
            for(int u=0;u<3;u++){
                for(int t=0;t<3;t++){
                    if("A".equals(arreglo[u][t])&&"A".equals(arreglo[u+1][t+1])&&"A".equals(arreglo[u+2][t+2])&&"A".equals(arreglo[u+3][t+3])){
                        n=1;
                        g=1;
                        break;
                    }
                    if("B".equals(arreglo[u][t])&&"B".equals(arreglo[u+1][t+1])&&"B".equals(arreglo[u+2][t+2])&&"B".equals(arreglo[u+3][t+3])){
                        n=1;
                        g=2;
                        break;
                    }
                }
            }
            for(int u=0;u<3;u++){
                for(int t=3;t<6;t++){
                    if("A".equals(arreglo[u][t])&&"A".equals(arreglo[u+1][t-1])&&"A".equals(arreglo[u+2][t-2])&&"A".equals(arreglo[u+3][t-3])){
                        n=1;
                        g=1;
                        break;
                    }
                    if("B".equals(arreglo[u][t])&&"B".equals(arreglo[u+1][t-1])&&"B".equals(arreglo[u+2][t-2])&&"B".equals(arreglo[u+3][t-3])){
                        n=1;
                        g=2;
                        break;
                    }
                }
            }
            if(n==1||n==2){
                System.out.println("El jugador "+g+" a ganado");
                for(i =0;i<6;i++){
                    for(j=0;j<6;j++){
                        System.out.print(arreglo[i][j]);
                        if(j==5){
                            System.out.print("\n");
                        }				
                    }
                }
            }
        }
    }
}