var Trans = artifacts.require("Trans");

var ether = 1000000000000000000;

contract('Trans', async (accounts) => {
    let instance;

    // console.log("[new instance]");
    // let instance = await Trans.deployed();
    // let instance = await Trans.at('0xff45683fc44bc57e1a0fa9944eba9a15d3e1d6eb');

    it("deploy contract", async () => {
        console.log("[new instance]");
        instance = await Trans.deployed();
    });

    it("register 10 IoT", async () => {
        for (let i = 0; i < 10; i++) {
            console.log("[registerIoT]");
            let x = await instance.registerIoT(accounts[i], `IoT ${i}`, {value:500*ether});
            // console.log(x)
        }

        let x = await instance.TranToken(accounts[9], 1000*ether);
        console.log("[xxxxxxxxxxxxxxxx]")
        console.log(x)

    });

    it("read 10 IoT infomation", async () => {
        for (let i = 0; i < 10; i++) {
            let readIoT = await instance.readIoT.call(1);
            // console.log(readIoT);
        }
    });

    it("insert newData", async () => {
        for (let i = 0; i < 10; i++) {
            let newData = await instance.newData(
                123,
                i,
                2018,
                2048,
                666,
                "weather"
                );
            // console.log(newData);            
        }
    });

    it("search Data", async () => {
        console.log("[searchData]");
        let searchData = await instance.searchData.call(accounts[0], 2019)
        // console.log(searchData)
    });

    // it("should be happy", async () => {
    //     // let instance = await Trans.deployed();
    //     // let instance = await Trans.at('0xff45683fc44bc57e1a0fa9944eba9a15d3e1d6eb');

    //     for (let i = 0; i < 10; i++) {
    //         console.log("[registerIoT]");
    //         let response = await instance.registerIoT(accounts[i], `IoT ${i}`);
    //     }

        
    //     console.log("[readIoT]");
    //     let readIoT = await instance.readIoT.call(1);
    //     console.log(readIoT);
    
    //     console.log("[newData]");

    //     for (let i = 0; i < 10; i++) {
    //         let newData = await instance.newData(
    //             123,
    //             i,
    //             2018,
    //             2048,
    //             666,
    //             "weather"
    //             );
    //         console.log(newData);            
    //     }

    //     console.log("[searchData]");
    //     let searchData = await instance.searchData.call(accounts[0], 2019)
    //     console.log(searchData)
        
    //  });
   
});