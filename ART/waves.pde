import java.util.Random;

class Waves {
    ArrayList<Wave> waveList;

    Waves(ArrayList<Wave> waveList){
        this.waveList = waveList;
    }

    Waves(float wavelength[], float amplitude[], float shift[]){
        try {
            waveList = new ArrayList<Wave>();
            for(int i = 0; i < wavelength.length; i++){
                this.waveList.add(new Wave(wavelength[i], amplitude[i], shift[i]));
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            println("Error: "+e);
        }
    }

    float update(float x, float yInit){
        float yFinal = yInit;
        for (Wave wave: waveList){
            // Random choice = new Random();
            // switch(choice.nextInt(6)) {
            //     case 0:
            //         yFinal += wave.waveSine(x);
            //         break;
            //     case 1:
            //         yFinal += wave.waveCosine(x);
            //         break;
            //     case 2:
            //         yFinal += wave.waveSquare(x);
            //         break;
            //     case 3:
            //         yFinal += wave.waveTriangle(x);
            //         break;
            //     case 4:
            //         yFinal += wave.waveSaw(x);
            //         break;
            // }
            yFinal += wave.waveSine(x);
        }
        return yFinal;
    }

    void render(int c, float x, float y, float size){
        fill(c);
        ellipse(x, y, size, size);
    }
}