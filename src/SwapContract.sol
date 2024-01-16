pragma solidity 0.8.23;

/**
 * @title Swap Contract
 * @author Anjanay Raina
 * @dev This contract allows users to swap one ERC20 token for another at a fixed rate.
 */
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SwapContract {
    event Swapped(address indexed sender, uint256 inputAmount, uint256 outputAmount);

    using SafeERC20 for IERC20;

    IERC20 private tokenA;
    IERC20 private tokenB;
    uint256 private rate;

    /**
     * @dev Constructor sets the tokens and the exchange rate.
     * @param _tokenA The address of Token A.
     * @param _tokenB The address of Token B.
     * @param _rate The exchange rate of Token A for Token B.
     */
    constructor(IERC20 _tokenA, IERC20 _tokenB, uint256 _rate) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        rate = _rate;
    }

    /**
     * @dev Swaps the specified amount of Token A for Token B.
     * @param amount The amount of Token A to swap.
     */
    function swapAforB(uint256 amount) public {
        tokenA.safeTransferFrom(msg.sender, address(this), amount);
        uint256 outputAmount = amount * rate;
        tokenB.safeTransfer(msg.sender, outputAmount);
        emit Swapped(msg.sender, amount, outputAmount);
    }

    /**
     * @dev Swaps the specified amount of Token B for Token A.
     * @param amount The amount of Token B to swap.
     */
    function swapBforA(uint256 amount) public {
        tokenB.safeTransferFrom(msg.sender, address(this), amount);
        uint256 outputAmount = amount / rate;
        tokenA.safeTransfer(msg.sender, outputAmount);
        emit Swapped(msg.sender, amount, outputAmount);
    }
}
