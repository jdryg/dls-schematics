Decoders are circuits which convert a N-bit input signal into 2<sup>N</sup> 1-bit output signals. Only one of the output signals will be HIGH (1) for any given input value. If the i-th output is 1, it means that the input had a value of `i`.

**NOTE**: 
1. All the circuits in this category use components from the [1-bit Multi-input Gates](https://github.com/jdryg/dls-schematics/tree/master/1-bit%20Multi-input%20Gates) category.
2. Since the outputs from each circuit are 2<sup>N</sup> independent signals, I could have used 2<sup>N</sup> 1-bit output ports. I decided to use a normal 2<sup>N</sup>-bit output port. When you componentize the circuits below, the generated component will have 2<sup>N</sup> output pins, since the output port is not a bus.

## Table of contents
* [1-to-2 Decoder](#1to2_decoder)
* [2-to-4 Decoder](#2to4_decoder)
* [3-to-8 Decoder](#3to8_decoder)

## Schematics

### <a name="1to2_decoder"></a>1-to-2 Decoder
[Schematic](1-to-2%20Decoder.sch)  
![1-to-2 Decoder](images/1_2_decoder.png "1-to-2 Decoder")

### <a name="2to4_decoder"></a>2-to-4 Decoder
[Schematic](2-to-4%20Decoder.sch)  
![2-to-4 Decoder](images/2_4_decoder.png "2-to-4 Decoder")

### <a name="3to8_decoder"></a>3-to-8 Decoder
[Schematic](3-to-8%20Decoder.sch)  
![3-to-8 Decoder](images/3_8_decoder.png "3-to-8 Decoder")
