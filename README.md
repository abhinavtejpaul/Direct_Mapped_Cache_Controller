"# Direct_Mapped_Cache_Controller" 

**Direct Mapped Cache Controller (32-bit) – Verilog Implementation**

This project implements a 32-bit Direct Mapped Cache Controller using Verilog HDL. The design models a simplified cache memory system that sits between a CPU and the main memory. The purpose of the cache is to reduce the average memory access time by storing frequently accessed data closer to the processor. When the CPU requests data, the cache controller checks whether the data is available in the cache (cache hit) or if it needs to fetch it from the main memory (cache miss). The design is fully simulation-based and can be tested using tools like Vivado or ModelSim.

**Cache Architecture**

The implemented cache is a Direct Mapped Cache consisting of 16 cache lines. Each cache line stores:

1. A data word (32 bits)
2. A tag value (24 bits)
3. A valid bit (1 bit)

The 32-bit address from the CPU is divided into three fields:

a. Tag (bits 31–8): Used to identify the memory block.
b. Index (bits 7–4): Selects the cache line.
c. Offset (bits 3–0): Selects the byte within a block (not heavily used in this simplified design).

**Modules in the Design**

1. *Cache Controller* - The cache_controller module acts as the central control unit. It receives the CPU address and read signal, extracts the tag and index, and checks the cache for a match. If the valid bit is set and the tag matches, a cache hit occurs and the cached data is returned to the CPU. Otherwise, a cache miss occurs and the controller retrieves the required data from the main memory and updates the cache.

2. *Data Array* - The data_array module stores the actual cached data. It consists of 16 entries, each storing a 32-bit value. When a cache hit occurs, this module returns the stored data for the selected index. When a cache miss occurs, new data fetched from main memory is written into the corresponding cache line.

3. *Tag Array* - The tag_array module stores the tag bits for each cache line. During a memory access, the tag extracted from the CPU address is compared with the stored tag. This comparison determines whether the requested memory block already exists in the cache.

4. *Valid Array* - The valid_array module stores a single valid bit for each cache line. The valid bit indicates whether the cache line contains valid data or not. If the valid bit is 0, the cache line is considered empty and the access results in a cache miss regardless of the tag comparison.

5. *Main Memory* - The main_memory module simulates the system RAM. It contains 256 memory locations, each storing 32 bits of data. During simulation, the memory is initialized with predictable values using the pattern memory[i] = i * 10. This makes it easy to verify correct functionality when observing simulation results.

6. *Testbench* - The testbench module generates clock signals, reset signals, and memory access requests to test the cache controller. It repeatedly sends memory addresses to the controller and monitors the hit signal and data_out signal to verify cache behavior.

**Simulation and Expected Behavior**
During simulation, the testbench sends a sequence of memory addresses such as:

0x10
0x10
0x20
0x10
0x30
0x30

The first time a new address is accessed, the cache will produce a cache miss because the cache is initially empty. The data is then fetched from the main memory and stored in the cache. When the same address is requested again, the controller detects that the tag matches and the valid bit is set, resulting in a cache hit.

**Waveform Analysis**

In the waveform viewer, the following signals can be observed:

*clk* – System clock driving the cache operations.
*reset* – Initializes the system.
*read* – Indicates a read request from the CPU.
*address* – Memory address requested by the CPU.
*hit* – Indicates whether the access was a cache hit or miss.
*data_out* – Data returned to the CPU.

The waveform should show the following pattern:

*First access to an address results in hit = 0 (cache miss).*
*The same address accessed again results in hit = 1 (cache hit).*
*The returned data matches the values stored in the main memory initialization.*

The X shown in the waveform is normal since in the start values of cache_data, tag_mem and valid_mem are not initialized. That is why it shows a X in the data waveform since it is undefined. 
