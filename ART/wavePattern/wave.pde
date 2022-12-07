class Wave {
    float wavelength;
    float amplitude;
    float shift;

    Wave(float wavelength, float amplitude, float shift){
        this.wavelength = wavelength;
        this.amplitude = amplitude;
        this.shift = shift;
    }

    void setLambda(float wavelength){
        this.wavelength = wavelength;
    }

     void setAmp(float amplitude){
        this.amplitude = amplitude;
    }

    void setShift(float shift){
        this.shift = shift;
    }

    float getLambda(){
        return this.wavelength;
    }

    float getAmp(){
        return this.amplitude;
    }

    float getShift(){
        return this.shift;
    }

    float waveSine(float x){
        return amplitude * sin((TWO_PI/wavelength) * radians(-x)+radians(shift));
    }

    float waveCosine(float x){
        return amplitude * cos((TWO_PI/wavelength) * radians(-x)+radians(shift));
    }

    float waveSquare(float x){
        return amplitude * Math.signum(sin((TWO_PI/wavelength) * radians(-x)+radians(shift)));
    }

    float waveTriangle(float x){
        return amplitude * sin((TWO_PI/wavelength) * radians(-x)+radians(shift));
    }

    float waveSaw(float x){
        return amplitude * sin((TWO_PI/wavelength) * radians(-x)+radians(shift));
    }
}