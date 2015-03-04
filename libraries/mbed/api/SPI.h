/* mbed Microcontroller Library
 * Copyright (c) 2006-2013 ARM Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef MBED_SPI_H
#define MBED_SPI_H

#include "platform.h"

#if DEVICE_SPI

#include "spi_api.h"

namespace mbed {

/** A SPI Master, used for communicating with SPI slave devices
 *
 * The default format is set to 8-bits, mode 0, and a clock frequency of 1MHz
 *
 * Most SPI devices will also require Chip Select and Reset signals. These
 * can be controlled using <DigitalOut> pins
 *
 * Example:
 * @code
 * // Send a byte to a SPI slave, and record the response
 *
 * #include "mbed.h"
 *
 * SPI device(p5, p6, p7); // mosi, miso, sclk
 *
 * int main() {
 *     int response = device.write(0xFF);
 * }
 * @endcode
 */
class SPI {

public:

    /** Create a SPI master connected to the specified pins
     *
     * Pin Options:
     *  (5, 6, 7) or (11, 12, 13)
     *
     *  mosi or miso can be specfied as NC if not used
     *
     *  @param mosi SPI Master Out, Slave In pin
     *  @param miso SPI Master In, Slave Out pin
     *  @param sclk SPI Clock pin
     */
    SPI(PinName mosi, PinName miso, PinName sclk, PinName _unused=NC);

    /** Configure the data transmission format
     *
     *  @param bits Number of bits per SPI frame (4 - 16)
     *  @param mode Clock polarity and phase mode (0 - 3)
     *
     * @code
     * mode | POL PHA
     * -----+--------
     *   0  |  0   0
     *   1  |  0   1
     *   2  |  1   0
     *   3  |  1   1
     * @endcode
     */
    void format(int bits, int mode = 0);

    /** Set the spi bus clock frequency
     *
     *  @param hz SCLK frequency in hz (default = 1MHz)
     */
    void frequency(int hz = 1000000);

    /** Write to the SPI Slave and return the response
     *
     *  @param value Data to be sent to the SPI slave
     *
     *  @returns
     *    Response from the SPI slave
    */
    virtual int write(int value);

    /** Write data from an array and read the response
     *  back into the same array
     *
     *  @param values Array of data exchanged between
     *                the master and slave
     *  @param len Number of data words to transfer
     *
     *  @returns
     *    Response from the SPI slave, via `values`
     */
    void transfer(int* values, int len);
    void transfer(uint8_t* values, int len);
    void transfer(uint16_t* values, int len);

    template <typename WordType, int len>
    void transfer(WordType (&values)[len]) {
        transfer(values, len);
    }

    /** Write data from an array
     *
     *  @param values Array of data to write to the slave
     *  @param len Number of data words to write
     */
    void write_array(const int* values, int len);
    void write_array(const uint8_t* values, int len);
    void write_array(const uint16_t* values, int len);

    template <typename WordType, int len>
	void write_array(const WordType (&values)[len]) {
	    write_array(values, len);
	}

    /** Read data from an array, writing all zeroes
	 *
	 *  @param values Array of data to read the slave response into
	 *  @param len Number of data words to read
	 *
	 *  @returns
     *    Response from the SPI slave, via `values`
	 */
	void read_array(int* values, int len);
	void read_array(uint8_t* values, int len);
	void read_array(uint16_t* values, int len);

	template <typename WordType, int len>
	void read_array(WordType (&values)[len]) {
		read_array(values, len);
	}

public:
    virtual ~SPI() {
    }

protected:
    spi_t _spi;

    void aquire(void);
    static SPI *_owner;
    int _bits;
    int _mode;
    int _hz;
};

} // namespace mbed

#endif

#endif
