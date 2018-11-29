var Trans = artifacts.require("Trans");

contract('Trans', async (accounts) => {

    it("should be happy", async () => {
        let instance = await Trans.deployed();
        // let instance = await Trans.at('0xff45683fc44bc57e1a0fa9944eba9a15d3e1d6eb');

        console.log("[instance]");

        for (let i = 0; i < 10; i++) {
            console.log("[registerIoT]");
            let response = await instance.registerIoT(accounts[i], `IoT ${i}`);
        }

        
        console.log("[readIoT]");
        let readIoT = await instance.readIoT.call(1);
        console.log(readIoT);

        // let newD = {
        //     h: 123,
        //     uid: 1,
        //     timestamp: 2018,
        //     datasize: 2048,
        //     supposedPrice: 666,
        //     dataType: "weather",
        // }
        
        console.log("[newData]");

        for (let i = 0; i < 10; i++) {
            let newData = await instance.newData(
                123,
                i,
                2018,
                2048,
                666,
                "weather"
                );
            console.log(newData);            
        }

        console.log("[searchData]");
        let searchData = await instance.searchData.call(accounts[0], 2019)
        console.log(searchData)
        
     });
   
});