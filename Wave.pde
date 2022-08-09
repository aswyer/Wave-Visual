//constants
int NUM_OF_WAVES = 3;

float WAVE_AMPLITUDE;
float WAVE_PERIOD;

int NUM_OF_CONTROL_POINTS = 5; //16
int WAVE_LR_OFFSET;

//helper variables
float WAVE_SPEED = 0;
int controlPointOffset;
float[] waveOffsets = new float[NUM_OF_WAVES];
float[] waveHeights = new float[NUM_OF_WAVES];

float noiseX = 0;

float[][] colors = new float[][] {
    {26, 188, 156}, 
    {46, 204, 113},
    {52, 152, 219},
    {155, 89, 182},
    {52, 73, 94},
    {22, 160, 133},
    {39, 174, 96},
    {41, 128, 185},
    {142, 68, 173},
    {44, 62, 80},
    {241, 196, 15},
    {230, 126, 34},
    {231, 76, 60},
    {236, 240, 241},
    {149, 165, 166},
    {243, 156, 18},
    {211, 84, 0},
    {192, 57, 43},
    {189, 195, 199},
    {127, 140, 141},
};

float[][] waveColors = new float[NUM_OF_WAVES][3];

void setup() {
    // size(600, 600);
    surface.setTitle("Waves");
    // surface.setResizable(true);
    // surface.setLocation(100, 100);
    fullScreen();
    pixelDensity( displayDensity() );
    
    noCursor();

    noFill();
    strokeWeight(4);
    stroke(255);

    noiseDetail(2);

    WAVE_AMPLITUDE = ((float) height)/3;
    WAVE_PERIOD = width/2;

    WAVE_LR_OFFSET = -width/3;
    controlPointOffset = (width-(2*WAVE_LR_OFFSET)) / NUM_OF_CONTROL_POINTS;

    randomize();
}

void randomize() { 
  //set values for each wave
    for(int wave = 0; wave < NUM_OF_WAVES; wave++) {
        //height
        waveHeights[wave] = WAVE_AMPLITUDE * random(0.2, 1);
        
        //color
        //for(int i = 0; i < 3; i++) {
        //  waveColors[wave][i] = 255 * random(0, 1);
        //}
        // waveColors[wave] = colors[ (int) random(0, colors.length) ];
    }
}


void draw() {
    background(0); //14, 32, 50

    for(int wave = 0; wave < NUM_OF_WAVES; wave++) {
        drawWave(wave);
    }
}


void drawWave(int waveNum) {
  
    // stroke(waveColors[waveNum][0], waveColors[waveNum][1], waveColors[waveNum][2]);
    
    beginShape();

    float sinXPos = waveOffsets[waveNum];

    float incrementalX = ((width/WAVE_PERIOD) * (2*PI)) / (float)NUM_OF_CONTROL_POINTS;

    float modifiedFrameCount = (float)frameCount/100;
    float trigModifier;
    if (waveNum % 2 == 0) {
        trigModifier = sin( modifiedFrameCount );
    } else {
        trigModifier = cos( modifiedFrameCount );
    }
    float modifiedHeight = waveHeights[waveNum] * ((trigModifier * 0.2) + (1 * 0.8));

    for(int xPos = WAVE_LR_OFFSET; xPos <= width-WAVE_LR_OFFSET; xPos += controlPointOffset) {

        float yOffset = sin(sinXPos) * modifiedHeight; //waveHeights[waveNum]
        float yPos = height/2 + yOffset;

        curveVertex(xPos, yPos); //curveVertex

        sinXPos += incrementalX;
    }

    endShape();

    //wave height
    // waveHeights[waveNum] = ;

    //general offset
    waveOffsets[waveNum] += WAVE_SPEED;

    //different offset for each wave
    for(int wave = 0; wave < NUM_OF_WAVES; wave++) {
        waveOffsets[wave] += 0.002 * wave;
    }

    float noiseVal = noise(noiseX, noiseX+1);
    float mappedNoiseVal = map(noiseVal, 0, 1, -0.28, 0.28);

    // println(mappedNoiseVal);
    WAVE_SPEED = mappedNoiseVal;
    noiseX += 0.0001;
}

// void keyPressed() {
//     if (key == CODED) {

//         if (keyCode == UP) { //up
//             WAVE_SPEED += 0.01;
//             // println("up");

//         } else if (keyCode == DOWN) { //down
//             WAVE_SPEED -= 0.01;
//             // println("down");
//         }

//     }
// }
