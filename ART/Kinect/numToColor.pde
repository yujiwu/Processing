/*
    Author: Yujie Wu
    Date: 12/05/22
    This class contains the methods that maps the value to a color
*/

public class NumToColor {

    // total numbers
    int total;
    // color array
    int [] arrColors;
    // numbers in each block
    int numInBlock;


    public NumToColor (float total, int [] arrColors) {
        this.total = int(total);
        this.arrColors = arrColors;
        this.numInBlock = this.total / this.arrColors.length;
    }

    // map a denary number to a hexdecimal which represents a color
    //
    // numColors: an array storing hexdecimal colors
    int getColor (int num){
        // in case there is less than one number in each block
        if (numInBlock == 0){
            return arrColors[num];
        }

        // calculate the number in which block
        int i = num / numInBlock;

        if (i >= arrColors.length){
            i = arrColors.length - 1;
        }

        return arrColors[i];
    }
}

