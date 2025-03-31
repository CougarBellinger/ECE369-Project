#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>


//alternate to calculating sum of absolute difference
int sadArray(int array1[], int array2[], int size){
    int sumAbsoluteDiff = 0;
    int difference;
    for(int i = 0; i < size; ++i){ 
        difference = array1[i] - array2[i];
        if(sumAbsoluteDiff < 0){
            sumAbsoluteDiff *= -1*difference;
        }
        else{
        sumAbsoluteDiff += difference;
        }
    }

    return sumAbsoluteDiff;
}
/*
int sad(int a[], int b[]){
    int difference;
    int total = 0;
    int arraySize;
    arraySize = (sizeof(a)/sizeof(a[0])); // this doesnt work because array decays to pointer
    
    printf("arraysize value: %d \n", arraySize);
    for(int i = 0; i < arraySize; ++i){
        difference = a[i] = b[i];
        printf("at element: %d \n", i + 1);
        if(difference < 0){
            difference *= -1;
        }
        printf("difference: %d \n" , difference);
        total += difference;
    }
    return difference;
}

*/

int absolute(int a, int b){ //3 operand friendly absolute value function
    int difference = a - b;
    if(difference < 0)
        difference *= -1;
    return difference;
}

void circularSearch(int Dimension[], int frame[], int window[]){

    int coordinates[2] = {0,0};

    int frameHeight = Dimension[0]; 
    int frameWidth = Dimension[1];   //needs to have own variable for 1d
    int windowHeight = Dimension[2]; //needs to have own variable for 1d?
    int windowWidth = Dimension[3]; //needs to have own variable for 1d
    
    int i = 0; //holds current row
    int j = 0; //holds current column
    int k = 0;
    int l = 0;

    int topBoundary = 0; 
    int leftBoundary = 0; //left boundary
    int rightBoundary = frameWidth - windowWidth + 1; //right boundary alt coding: windowFrame[1] - windowFrame[3]
    int bottomBoundary = frameHeight- windowHeight - 1; // bottom boundary " " : windowFrame[0] - windowFrame[2]

    int count = 0;
    int sumABS = 0; 
    int minABS = 999999;
    
    
    //printf("in one dimension mode\n");
    while(1){
    
        //printf("left to right\n");
        //-----------------------------------------------------
        // left to right movement 
        //-----------------------------------------------------

        for(i = leftBoundary; i < rightBoundary; ++i){
            //printf("current index: [%d][%d]\n" ,j, i);

            //squish array do absum
            sumABS = 0; 
            int m = 0;

            //change implementation for 1d array
            for(l = 0; l < windowHeight; ++l){
                for(k = 0; k < windowWidth; ++k){
                    //debug use printf("values : [%d] and [%d]\n" , frame[i + (l * frameWidth) + k], window[m]);

                    sumABS += absolute(frame[i + ((l + j) * frameWidth) + k], window[m]); // l changes row, k changes column

                    //printf("sumABS = %d \n", sumABS);

                    ++m;
                }
            }
            
            //printf("sumABS = %d \n", sumABS);
            
            //printf("\n");
            //printf("\n");

            if(sumABS < minABS){
                printf("new low found!\n");
                coordinates[0] = j;
                coordinates[1] = i;

                printf("%d, %d\n", coordinates[1], coordinates[0]);
                minABS = sumABS;
            }
        }

        i = rightBoundary;

        if (topBoundary < bottomBoundary)
            topBoundary += 1;
        else   
            break;

        //-----------------------------------------------------



        // printf("top to bottom\n");
        //-----------------------------------------------------
        //  top to bottom movement
        //-----------------------------------------------------

        for(j = topBoundary; j < bottomBoundary; ++j){
            //printf("current index: [%d][%d]\n" ,j, i);

            sumABS = 0;
            int m = 0;

            for(l = 0; l < windowHeight; ++l){
                for(k = 0; k < windowWidth; ++k){
                    //debug use printf("values : [%d] and [%d]\n" , frame[i + (l * frameWidth) + k], window[m]);

                    sumABS += absolute(frame[i + ((l + j) * frameWidth) + k], window[m]); // l changes row, k changes column
                    //printf("sumABS = %d \n", sumABS);
                    ++m;
                }
            }
            //printf("\n");
            //printf("sumABS = %d \n", sumABS);
            
            //printf("\n");
            
            //printf("\n");
            if(sumABS < minABS){
                printf("new low found!:\n");
                coordinates[0] = j;
                coordinates[1] = i;

                printf("%d, %d\n", coordinates[1], coordinates[0]);
                minABS = sumABS;
            }
            
        //printf("\n");
        }
        
        
        j = bottomBoundary;
        //printf("bottom boundary currently is: %d\n" , bottomBoundary);
        if (rightBoundary > leftBoundary)
            rightBoundary -= 1;
        else
            break;


        //printf("right to left\n");
        //-----------------------------------------------------
        // right to left movement
        //-----------------------------------------------------

        for(i = rightBoundary; i > leftBoundary; --i){//right to left
            //printf("current index: [%d][%d]\n" ,j, i);
            sumABS = 0;
            int m = 0;
            for(l = 0; l < windowHeight; ++l){
                for(k = 0; k < windowWidth; ++k){
                    //debug use printf("values : [%d] and [%d]\n" , frame[i + ((l + j) * frameWidth) + k], window[m]);
                    sumABS += absolute(frame[i + ((l + j) * frameWidth) + k], window[m]); // l changes row, k changes column
                    //printf("sumABS = %d \n", sumABS);
                ++m;
                }
            }
            //printf("sumABS = %d \n", sumABS);
            
            //printf("\n");
            
            //printf("\n");
            if(sumABS < minABS){
                printf("new low found!\n");
                coordinates[0] = j;
                coordinates[1] = i;

                printf("%d, %d\n", coordinates[1], coordinates[0]);
                minABS = sumABS;
            }
            //return;
            
        //printf("\n");
        }

        i = leftBoundary;
        
        //must be checked before bottom to top

        if (bottomBoundary > topBoundary)
            bottomBoundary -= 1;
        else
            break;


        // printf("bottom to top\n");
        //-----------------------------------------------------
        //  bottom to top movement
        //-----------------------------------------------------

        for(j = bottomBoundary; j > topBoundary; --j){//bottom to top
            //printf("current index: [%d][%d]\n" ,j, i);
            sumABS = 0;
            int m = 0;
            for(l = 0; l < windowHeight; ++l){
                for(k = 0; k < windowWidth; ++k){
                    //debug use printf("values : [%d] and [%d]\n" , frame[i + (l * frameWidth) + k], window[m]);
                    sumABS += absolute(frame[i + ((l + j) * frameWidth) + k], window[m]); // l changes row, k changes column
                    //printf("sumABS = %d \n", sumABS);
                    ++m;
                }
            }
            //printf("\n");
            
            //printf("sumABS = %d \n", sumABS);
            
            //printf("\n");
            
            //printf("\n");
            if(sumABS < minABS){
                printf("new low found!\n");
                coordinates[0] = j;
                coordinates[1] = i;

                printf("%d, %d\n", coordinates[1], coordinates[0]);
                minABS = sumABS;
            }
        }
        j = topBoundary;

        if (leftBoundary < rightBoundary /*&& count > 0*/)
            leftBoundary += 1;
        else
            break;

        ++count;
}


    printf("the sum absolute difference is: %d at coordinate %d , %d\n" , minABS, coordinates[0], coordinates[1]);


}

/*
# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4
*/



int main(void){
    //result 0, 2
    int dimension0[4] = {4,  4,  2, 2};  
    int frame0[16] = {0,  0,  1,  2,
                        0,  0,  3,  4,
                        0,  0,  0,  0,
                        0,  0,  0,  0,
    };
    int window0[4] = {1,  2, 3,  4};
    
    //restult 
    int dimension1[4] = {16,  16,  4, 4};
    int frame1[256] = {0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                       1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                       2, 3, 32, 1, 2, 3, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
                       3, 4, 1, 2, 3, 4, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45,
                       0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60,
                       0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75,
                       0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90,
                       0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105,
                       0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120,
                       0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135,
                       0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150,
                       0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165,
                       0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3,
                       0, 13, 26, 39, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4,
                       0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5,
                       0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6
    };
    int window1[16] = { 0, 1, 2, 3,
                        1, 2, 3, 4, 
                        2, 3, 4, 5, 
                        3, 4, 5, 6
    };

    int dimension2[4] = {16, 16, 4, 8};   
    int window2[32] = {0, 0, 0, 0, 0, 0, 0, 0, 
                0, 0, 0, 0, 0, 0, 0, 0, 
                0, 0, 0, 0, 0, 0, 0, 0, 
                0, 0, 0, 0, 0, 0, 0, 0};
    int frame2[256] = {7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
        7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
        7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
        7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
        0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
        0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 0, 0, 0, 0, 70,  75, 
        0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 0, 0, 0, 0, 84, 90, 
        0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 0, 0, 0, 0, 98, 105, 
        0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 0, 0, 0, 0, 112, 120, 
        0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
        0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
        0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
        9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
        9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
        9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
        9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6
};
    //test case 3
    int dimension3[4] = {4, 4, 4, 4};
    int frame3[16] =  {9, 9, 9, 9, 
                    9, 9, 9, 9, 
                    9, 9, 9, 9, 
                    9, 9, 9, 9};

    int window3[16] = {9, 9, 9, 9,
                   9, 9, 9, 9, 
                   9, 9, 9, 9,
                   9, 9, 9, 9};

    //test case 4
    int dimension4[4] = {16, 16, 4, 4};
    int frame4[256] = {9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 7, 7,
                       9, 7, 7, 7, 7, 5, 6, 7, 8, 9, 10, 11, 6, 7, 7, 7,
                       9, 7, 7, 7, 7, 3, 12, 14, 16, 18, 20, 6, 6, 7, 7, 7,
                       9, 7, 7, 7, 7, 4, 18, 21, 24, 27, 30, 33, 6, 7, 7, 7,
                       0, 7, 7, 7, 7, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60,
                       0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75,
                       0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90,
                       0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105,
                       0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120,
                       0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135,
                       0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150,
                       0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165,
                       9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3,
                       9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4,
                       9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5,
                       9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6
                       };

    int window4[16] = {7, 7, 7, 7,
                       7, 7, 7, 7,
                       7, 7, 7, 7,
                       7, 7, 7, 7
    };

    //test case 13
    int dimension13[4] = {32, 32, 4, 4};
    int frame13[1024] = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    };

    int window13[16] = {
        10, 10, 10, 10,
        10, 10, 10, 10,
        10, 10, 10, 10,
        10, 10, 10, 10
    };

    printf("test case 0\n");
    circularSearch(dimension0, frame0, window0); //result 0, 2

    printf("test case 1\n");
    circularSearch(dimension1, frame1, window1); //result should be 12, 12

    printf("test case 2\n");
    circularSearch(dimension2, frame2, window2); //result should be 0, 4

    printf("test case 3\n");
    circularSearch(dimension3, frame3, window3); //result should be 0,0

    printf("test case 4\n");
    circularSearch(dimension4, frame4, window4); //result should be 1, 1

    printf("test case 13\n");
    circularSearch(dimension13, frame13, window13); //The result should be 5, 16 since its the first of multiple repeating occurences
    // experimentally returns 17, 16

    return 0;
}