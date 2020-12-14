// PBT ICO

// Version of compiler
pragma solidity >=0.7.0 <0.8.0;

contract pbt_ico {
    
    // The maximum number of PBT available for sale 
    uint public max_pbt = 1000000;
    
    // Creating the conversion rate
    uint public usd_to_pbt = 10;
    
    // The total number of PBT that have been bought by investors
    uint public total_pbt_bought = 0;
    
    // Mapping from the investor address to its equity in PBT and USD
    mapping(address => uint) equity_pbt;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy PBT
    modifier can_buy_pbt(uint usd_invested) {
        require (usd_invested * usd_to_pbt + total_pbt_bought <= max_pbt);
        _;
    }
    
    // Get the equity in PBT of an investor
    function equity_in_pbt(address investor) external constant returns (uint) {
        return equity_pbt[investor];
    }
    
    // Get the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buy PBT
    function buy_pbt(address investor, uint usd_invested) external
    can_buy_pbt(usd_invested) {
        uint pbt_bought = usd_invested * usd_to_pbt;
        equity_pbt[investor] += pbt_bought;
        equity_usd[investor] = equity_pbt[investor] / 10;
        total_pbt_bought += pbt_bought;
    }
    
    // Sell PBT
    function sell_pbt(address investor, uint pbt_sold) external {
        equity_pbt[investor] -= pbt_sold;
        equity_usd[investor] = equity_pbt[investor] / 10;
        total_pbt_bought -= pbt_bought;
    }
    
}